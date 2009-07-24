From: Elijah Newren <newren@gmail.com>
Subject: Re: [RFC PATCH v2 1/3] Introduce git-unstage
Date: Fri, 24 Jul 2009 12:23:03 -0600
Message-ID: <51419b2c0907241123s4ce39ef0q99a25132429cad61@mail.gmail.com>
References: <2d756f643fc7d1b50cf590c95467fa029b49ff46.1248426652.git.trast@student.ethz.ch>
	 <683ed99f389d643d21bda6750bd2ee9caf287625.1248452530.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 24 20:23:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUPQK-0007eT-SZ
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 20:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821AbZGXSXH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jul 2009 14:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753798AbZGXSXH
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 14:23:07 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:60480 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651AbZGXSXF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jul 2009 14:23:05 -0400
Received: by an-out-0708.google.com with SMTP id d40so2264087and.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 11:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3DOwvWDd3joeLVl0jIrj9oqAWmiA6aB2oHVaeZfSSSM=;
        b=VdUWq7+xfycV7lAWRuKBKtsFaC5NMQx1ruoD/BTLli62nPvXwMpWPih6ee3pMXyIK3
         6c5ini8EXae1kVaT/KbzxCsLedigpdhRb297KL6cM2P17Fin/koc/3sOCJVjka3P6nHQ
         MqKHDOp7wqwHV08y++gxcmoR9jrXFgjrkMcDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=krYcKgaS9kmXB1VzfjHp2XheUg/b8zRVqk2nOO+Wf8aVblQsHMSGdbzuHWvAgIFklq
         udK0sCjv7bN0DwiRIX2XiSM7+kWvAxNfs4Uey2vY7Z6gwzN2634WFoISXJG62DYl7n5s
         iHXMrgifl58UcMftccZTOuyuiTKgqPN5Gv82k=
Received: by 10.100.38.12 with SMTP id l12mr4768992anl.167.1248459784991; Fri, 
	24 Jul 2009 11:23:04 -0700 (PDT)
In-Reply-To: <683ed99f389d643d21bda6750bd2ee9caf287625.1248452530.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123939>

On Fri, Jul 24, 2009 at 10:24 AM, Thomas Rast<trast@student.ethz.ch> wr=
ote:
> The new command 'git unstage' is the precise opposite of 'git stage'
> (i.e., git-add). =C2=A0As such, it is the same as 'git reset --' unle=
ss the
> current branch is unborn.

I really, really like the idea of being able to do something like
unstage -p.  That's sweet, thanks for working on that.

Some potential issues, though:

git unstage may cause issues for some people if they try to use it
when in the middle of a merge (why reset back to HEAD rather than one
of the other branches being merged?).  With git reset, one can specify
which commit to reset the index back to.  With your 'unstage' command,
you not only assume 'HEAD' but don't allow specifying any other value.
 You could add a commit argument here, but that may be problematic
wording-wise, in that you're allowing to 'unstage' back to a specified
commit, with the possibly perplexing result that you have 'staged'
something else.

Also, you have added two new commands, unstage and discard, which are
two pieces of an hg-like revert (revert edits).  We still don't have a
command for a full hg-like revert, though (git checkout does not cover
the bases), and to cover that we'd have to add a third command.
Perhaps the three could be combined?


Elijah
