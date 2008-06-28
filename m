From: "Robert Anderson" <rwa000@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 20:31:03 -0700
Message-ID: <9af502e50806272031t48be3f2sa24fc666ac341837@mail.gmail.com>
References: <g43jlg$54g$1@ger.gmane.org> <-8386235276716376372@unknownmsgid>
	 <9af502e50806271555j3cd06ecau122b11217f612217@mail.gmail.com>
	 <7viqvuo4hq.fsf@gitster.siamese.dyndns.org>
	 <9af502e50806271708p7979ae65k61b71be90efff2c4@mail.gmail.com>
	 <20080628025704.GJ5737@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"David Jeske" <jeske@willowmail.com>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 05:32:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCRAV-0000WU-2o
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 05:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbYF1DbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 23:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbYF1DbI
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 23:31:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:57497 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbYF1DbG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 23:31:06 -0400
Received: by fg-out-1718.google.com with SMTP id 19so373768fgg.17
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 20:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=K4LpeO1ZVSuLX7HNJpk+dXzHDFG1yiLHln207FG6+U4=;
        b=WM32nGs0s664e6wAGrkClpo91QHb4EjBc/BB/kNcetQklPuiWtQE4+kvz/c6EYMCsd
         5VVbSGnLaINu6a6Ylz6uL+S9V1sF9jqZ82aH9kBUrGfroSdJXIOIkh1EYaoIOiVgZas4
         g7XcK9mXwWY93zN98+4LvYxxFom1iJXueIPW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=REL5eUxCk9za8GxQstd+4AwDV/i1bsSLV6necXIyyF8g80mjLcBm9XV+YHSpStlVfj
         dlYnHbonY1fSS4XhHY86nI3O6DYMSvIH9fj41tM/ACkEkVdMwGRMg3AviZ0QZoEHPdXB
         NXToDc/0JPrvlkcoIsEnWYCUagV5vuN8egMWU=
Received: by 10.86.23.17 with SMTP id 17mr2917279fgw.32.1214623863755;
        Fri, 27 Jun 2008 20:31:03 -0700 (PDT)
Received: by 10.86.4.6 with HTTP; Fri, 27 Jun 2008 20:31:03 -0700 (PDT)
In-Reply-To: <20080628025704.GJ5737@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86697>

On Fri, Jun 27, 2008 at 7:57 PM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Fri, Jun 27, 2008 at 05:08:57PM -0700, Robert Anderson wrote:
>>
>> In the existing model which is being suggested as a way to get the
>> desired workflow, there are two distinct classes of commits:  commits
>> that are "for real", and commits that are "temporary", that are being
>> used as some kind of workspace for orthogonalizing a set of changes,
>> which will eventually be replaced by "for real" commits.
>
> Not really. Good commits do not get replaced by anything. They are
> just pushed to the public repo after being tested. Those commits
> that have not passed the test should be amended and tested again.
>
>> Yet git has
>> no metadata to distinguish these two types of commits.  When only "for
>> real" commits exist, I can push HEAD.  When "temporary" commits exist,
>> I cannot, or insidious problems will ensue.  This metadata concerning
>> "for real" or "temporary" commits is only maintained manually in the
>> developer's head.
>
> No, you can use a tag for that, which marks the tip of tested commits;
> or you can make your test procedure to push commits automatically after
> successful testing. There is no reason for Git to have any metadata for
> that.
>
> Dmitry

There is a disconnect here.  Rather than argue somewhat abstractly,  I
will try to construct some concrete examples which illustrate the
essential problems with the current model and some proposed solutions
to improve it.

Bob
