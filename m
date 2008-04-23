From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git-gc doesn't clean up leftover objects after git-filter-branch unless you clone first
Date: Wed, 23 Apr 2008 14:36:04 -0400
Message-ID: <32541b130804231136n73127cb9rea242981da28ac47@mail.gmail.com>
References: <32541b130804230841h32c07f3arc94cccfaf0b156a3@mail.gmail.com>
	 <7vve28sdys.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 20:37:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jojpz-0003M2-Uw
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 20:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbYDWSgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 14:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbYDWSgM
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 14:36:12 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:55479 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbYDWSgL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 14:36:11 -0400
Received: by fk-out-0910.google.com with SMTP id 19so3931989fkr.5
        for <git@vger.kernel.org>; Wed, 23 Apr 2008 11:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ySnJb0mfokhKrX2laRhYThAneMB6T0g0QfBsoU+neZc=;
        b=CcOcuRU2eDcO9apItALOWN9cdrGw2CkvRaSSdbB9LH8lFz66gKdFGYA1yHkzD7PnRl4/MegM6eV4lmmdAPErd83ZgUgj52otd51XgzZcSdzeFf3HlKx6XPQ7wWmMqTjtXoMOzhQcKkNl1TmQbGkMgwqAjL0Wu1asP9Sv1w8o4ak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l1XjLOxuyVjbeApmPr/R6qomRehNK9lkGrEkFzhtd8idRyC+P4+GVMnnUZ4U7qt9dUqjOS/K4Rgqc7g4IwcVAf5BIv5edor3YCS66EVTp9ZO8VEVFZqrzB3NRTDehwucrt2qVmQ9VJYJ1C1ZcFaqqQ1hExc7ZUOM4dTKCEChWV8=
Received: by 10.82.165.5 with SMTP id n5mr1489085bue.84.1208975764327;
        Wed, 23 Apr 2008 11:36:04 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Wed, 23 Apr 2008 11:36:04 -0700 (PDT)
In-Reply-To: <7vve28sdys.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80236>

On 4/23/08, Junio C Hamano <gitster@pobox.com> wrote:
> "Avery Pennarun" <apenwarr@gmail.com> writes:
>
>  > This question has come up at least once a week since I subscribed to
>  > the list.  I can think of these solutions:
>  >
>  > - Add a note to the git-gc and/or git-repack man page about how hidden
>  > refs can impact the cleanup.
>  >
>  > - Add an option to make git-clone *not* hardlink stuff; its different
>  > behaviour for hardlinking vs. file:// seems to be very confusing.
>  >
>  > - Make git-gc give a warning when there are some objects that are only
>  > referenced via the reflog or refs/original.  (I suspect this would
>  > trigger too often though.)
>  >
>  > - Give git-gc a "really, I'm serious" option that makes it ignore the
>  > reflog and refs/original.
>
> - Teach people that leftover cruft is nothing to worry about.

I think any option that starts with "teach people" will not reduce FAQ
traffic to the list :)  But maybe we could remind people of this
somewhere prominent.  The git-filter-branch man page?

That said, I think I know why people are concerned about the cruft:
it's for the same reason I was when I first tried git-filter-branch to
get rid of some gigantic files after importing from svn, to cut the
size of a clone from >1GB to <100MB.  It's impossible to see if I've
succeeded or not unless I make an actual clone, and even *then* I was
misled at first because making a local clone is clever and avoids
doing any work.

Avery
