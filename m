From: Thomas Berg <merlin66b@gmail.com>
Subject: Re: [PATCH] git-p4: Corrected typo.
Date: Mon, 31 Jan 2011 13:51:07 +0100
Message-ID: <AANLkTinrALdy9w7K50r=k-oMV9V5+7+LKvui_DSmJ6nK@mail.gmail.com>
References: <1290130693-30855-2-git-send-email-vitor.hda@gmail.com>
	<1290648419-6107-1-git-send-email-vitor.hda@gmail.com>
	<AANLkTimQhFzEXr=T9F8TJzTeWwKroTt_BG87RtQCLivv@mail.gmail.com>
	<AANLkTikeB724f_vE6qvu1h1o5JG150mcmaHVBjLkOEWP@mail.gmail.com>
	<AANLkTimLQxiB=dnd6=iB5uEpzOSfqks=FDJ=xORehuw8@mail.gmail.com>
	<AANLkTi=PPN69uuJmUBDHKtmn59DzUbdk=Qu4Ug-kok89@mail.gmail.com>
	<AANLkTi=kmcWn9WWbhA4bMZ5bEo1imacEugT0BcOU9jry@mail.gmail.com>
	<AANLkTinCL6+oTAbh4WpsWHx8cZ8cxZvQxSO9EX_xsHh0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 13:51:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjtDz-0005nB-RK
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 13:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755646Ab1AaMvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 07:51:10 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47112 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755536Ab1AaMvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 07:51:09 -0500
Received: by qyj19 with SMTP id 19so3373859qyj.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 04:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=AtOKhOVhhsttvwYVI4G+YW6l3Xsl7sjwhhuBSm3dHZs=;
        b=x/LKlycOL28DqHBNMRfkKdKjIk7VHoCsvIQtqdwWmClhfsgXk/u/K/74J1ip6wFpXK
         JEc586QnBA40zpwbaVSP17azAKtkhTHX4y2djK1UxX5QEEaU17L3vAdsFlJfepGLc0zJ
         i8ge7Tx0KSS7lBN3itOxkcI3LltIiqPRXImIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=HJqHxsEjbMxD22/WUpAtAN7z0/jB0DjFrBGurdJCKnVhpLNdPzh7FxdAGsTxA7Q8To
         6nsDXMW4BgflXfAtrqSLOe9UKasD7uxAH859tz+LdK+F6GouxRyYOLHsVAmCpfXeIu6/
         T1/R8YQNNQONtML1WJr2lPuScfYU6f+7Wf++Q=
Received: by 10.229.183.193 with SMTP id ch1mr4061301qcb.107.1296478267714;
 Mon, 31 Jan 2011 04:51:07 -0800 (PST)
Received: by 10.229.223.131 with HTTP; Mon, 31 Jan 2011 04:51:07 -0800 (PST)
In-Reply-To: <AANLkTinCL6+oTAbh4WpsWHx8cZ8cxZvQxSO9EX_xsHh0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165726>

Hi Vitor,

On Mon, Jan 31, 2011 at 12:25 PM, Vitor Antunes <vitor.hda@gmail.com> wrote:
>> No, the Perforce repo I work with is so non-standard that the only
>> solution has been to import all the branches separately and graft the
>> history together. This covers all my needs at the moment.
>
> Maybe I'm not seeing some obvious limitation, but I can't imagine a
> branching structure that can't be imported into git. Could please you
> give me an example?

Here I was thinking of the fact that git-p4 (last time I checked the
implementation ) uses the list of branch specs in Perforce for
figuring out the parent of a branch. Our branch specs have changed
over time (they are used for different integration purposes), so they
are no longer usable for this purpose.

I also discovered bugs in git-p4: in some cases, if the first submit
to a new branch in Perforce is not identical to the branch it derives
from, the import was not correct.

One other issue with Perforce, CVS and many other systems is that they
branch per file. Therefore Perforce can represent partial merges
between two branches, which git cannot. Because of this, translating
merges in Perforce to merges in git is not always possible or
desirable:
- if you integrate just one file from one branch to another in
Perforce, and leave the rest unmerged, you probably want to represent
it as a normal git commit (not a merge)
- if you merge almost everything, but leave out a file for some
reason, you may still want to represent it as a merge in git

The git-p4raw tool has excellent handling of merges, see details in
this file around line 4300:
https://github.com/samv/git-p4raw/blob/master/git-p4raw
It supports several algorithms for automatic merge detection, as well
as manually changing it after the import is done.

Cheers,
Thomas
