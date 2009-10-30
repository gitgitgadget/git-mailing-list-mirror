From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [Vcs-fast-import-devs] What's cooking in git.git (Oct 2009, #01; 
	Wed, 07)
Date: Fri, 30 Oct 2009 05:41:36 -0700
Message-ID: <fabb9a1e0910300541w40d17242rbf0683654d97457f@mail.gmail.com>
References: <7viqeqjsx6.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910080848380.4985@pacific.mpi-cbg.de> 
	<fabb9a1e0910072349q68d6756cgebb041a0bbe2ba65@mail.gmail.com> 
	<20091008173900.GI9261@spearce.org> <fabb9a1e0910081058m59527600o392a6b438b18512e@mail.gmail.com> 
	<4AEA626D.8060804@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: vcs-fast-import-devs@lists.launchpad.net, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Ian Clatworthy <ian.clatworthy@canonical.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 13:42:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3qnr-0006qQ-PU
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 13:42:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756742AbZJ3Mlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 08:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756073AbZJ3Mlx
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 08:41:53 -0400
Received: from mail-ew0-f228.google.com ([209.85.219.228]:50452 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755140AbZJ3Mlw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 08:41:52 -0400
Received: by ewy28 with SMTP id 28so2944166ewy.18
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 05:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=2I5ezlL9gO+Z20wEARRMbrtAZEcKgB8SEUQXlxUvYuY=;
        b=a79SEQMli8bij7HuycWJXNukWk1UjSP7LFoG2q5GI72mRxX075n3M0udRcKd+r7Szs
         U9BZOAZQinwbQlgjbAypvlQgIKsC3Jg4eT/CkdKxt/3ZRz03ry0Gt3XSuJTKIdzCC/52
         EInf8Sb+IGOJomxR/I3AQXTkwP3/x/8ruW5DQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ox8JhljsfbmheGEMfK386KHeJ/fubXLkbcdi7RXsdgyH+MsHhuGqAz79nCT0MQC0Jn
         30pMPBgFVoooGHUeKFs9J0cbob3YY9NegLjb12bXYQNJ85srF/NVTUdzdpoYC69mg/qw
         GvtOaqhr/jMQhQBjk2lezJT5Ku90yoCendZ10=
Received: by 10.216.87.81 with SMTP id x59mr521219wee.147.1256906516107; Fri, 
	30 Oct 2009 05:41:56 -0700 (PDT)
In-Reply-To: <4AEA626D.8060804@canonical.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131702>

Heya,

On Thu, Oct 29, 2009 at 20:50, Ian Clatworthy
<ian.clatworthy@canonical.com> wrote:
>> On Thu, Oct 8, 2009 at 19:39, Shawn O. Pearce <spearce@spearce.org> wrote:
> Sverre Rabbelier wrote:
>> [edited Shawn's message somewhat to be more relevant to vcs-fast-import-dev]
>
> Thanks Sverre. Before I start, sorry for taking so long to reply to this.

Thanks for the review :).

> My strong preference is for:
>
> * feature = anything impacting semantics
> * option = tool-specific with no impact on semantics permitted.
>
> Both features and options ought to OS independent (where possible).

Even better, Shawn, if this LGTY I will reroll the series implementing this.

>>> I think we want to declare features for import-marks and export-marks
>>> and define these as paths to local files which store a VCS specific
>>> formatted mapping of fast-import mark numbers to VCS labels.
>
> Explicitly specifying the local path names worries me though. Consider someone
> using fastimport tools to maintain multiple mirrors in different tools.
> What should the stream look like then? Does it need to change if we want
> an additional mirror.

I think the stream should not have to change, which works if you
define the files to be local to the repo being exported to.  That is,
in git the line "feature export-marks=out.marks" would result in a
marks file located in "/path/to/repo/.git/fast-import/out.marks". Or
is that not what you mean?

> +1. By forcing tools to know about options specific to them, we avoid a
> range of bugs processing newer streams with older tools.

It is not possible to change the semantics using options though, what
kind of bugs could arise this way?

> I don't think options should be permitted to change import behavior. In
> other words, we should actively discourage vcs-specific streams

Sounds fair, I reckon that a wiki in addition to the
vcs-fast-import-devs list would not hurt :).

-- 
Cheers,

Sverre Rabbelier
