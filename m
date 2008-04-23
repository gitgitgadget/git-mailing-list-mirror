From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: git-gc doesn't clean up leftover objects after git-filter-branch unless you clone first
Date: Wed, 23 Apr 2008 11:41:42 -0400
Message-ID: <32541b130804230841h32c07f3arc94cccfaf0b156a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 23 17:42:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Joh78-00080i-TH
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 17:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbYDWPlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 11:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbYDWPlp
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 11:41:45 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:60714 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbYDWPlo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 11:41:44 -0400
Received: by fk-out-0910.google.com with SMTP id 19so3852997fkr.5
        for <git@vger.kernel.org>; Wed, 23 Apr 2008 08:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=3j5/JX+Eo2kaHJzymYEqGVLZVJGO3JZmUsZRlu23oGI=;
        b=N0MwctahSRdh2N1VYB1IzCg3v8xaUTQVtiH/ra40Tr2oGVsQUEmlo/CFyt46m22TDpgx25gnhUjxjs+pSBjsz/wvEferUcNRM3y5oDdSC4g4BKTlWEhj9pGwuzb5YVg2HUaTqtUXoXJnECeIHWZStKTyoiw8CfRFHIGNZSsq5XA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qsB0aYHcP+bQYYyvQ3ijxqJyl/49aEkl4ZSRoqouj9YamUT2HNTGE+KfsDkoRguGSvxFFZQWvlbaaRcj/eWiyQaw2WkbDHKs48ZeLhAWuqLoYXPR7IR+VoSLA4F7GSOq/PlmKPQW4XGrBXzLGRhNNcMhzEmhqpMP04n7EFfZm/4=
Received: by 10.82.160.19 with SMTP id i19mr1192964bue.78.1208965302748;
        Wed, 23 Apr 2008 08:41:42 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Wed, 23 Apr 2008 08:41:42 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80224>

On 4/23/08, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Peter Karlsson schrieb:
> > [Not seeing any unreachable objects]
>
> > Jeff King:
> >> Did you remove refs/original/ ?
>  >
>  > That, and cloned the repository to a new location after the conversion,
>  > and removing the references to "origin" there. It does seem that the
>  > objects are still there, but I can't see them with "gitk --all".
>
> Did you clone locally? Then you must use the file:// protocol, otherwise
>  everything is hard-linked from the origin.

This question has come up at least once a week since I subscribed to
the list.  I can think of these solutions:

- Add a note to the git-gc and/or git-repack man page about how hidden
refs can impact the cleanup.

- Add an option to make git-clone *not* hardlink stuff; its different
behaviour for hardlinking vs. file:// seems to be very confusing.

- Make git-gc give a warning when there are some objects that are only
referenced via the reflog or refs/original.  (I suspect this would
trigger too often though.)

- Give git-gc a "really, I'm serious" option that makes it ignore the
reflog and refs/original.

Thoughts?

Avery
