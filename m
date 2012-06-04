From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCHv6 4/4] status: better advices when splitting a commit
 (during rebase -i)
Date: Mon, 4 Jun 2012 11:35:50 -0400
Message-ID: <CABURp0pD-QuAsDAJXnQXn3sTLb__maw0Mc30PHhduTZ9YOB1FQ@mail.gmail.com>
References: <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338748217-16440-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <1338748217-16440-4-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Moy Matthieu <Matthieu.Moy@grenoble-inp.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 04 17:36:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbZKK-00042w-Rw
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 17:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760793Ab2FDPgM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jun 2012 11:36:12 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:55884 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587Ab2FDPgL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2012 11:36:11 -0400
Received: by gglu4 with SMTP id u4so3112319ggl.19
        for <git@vger.kernel.org>; Mon, 04 Jun 2012 08:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2Y9nO95f2eCZeQMG8KaOmt10Fdhn8WUMRHsJNUj5lgg=;
        b=iaIjKKkTbG4avw9sQRM/3TcAndY777V8XJfc7w+apwnr2gV2gctsUP2YZH7m0clwBZ
         bHDnPL+3o/SaLtlLy7o566DZHDWeZStqH3QISMVlAyYwHdzUxWoK88FNzceMELqdMvsb
         mM7YzVBChxNZPIiy8mskpHCGwLbEbyY0swGMAOdEm7XlTqudO1fUbkyCZI4e5/x8woZS
         BhNLNYaXVyozw34idTBJ/nNmmIAwuNcQTMur5Q218k3E93CUEGMK+pt6wBDOC1mRt29d
         KVVY6m+sNsUixOjZSxoEMSw+VYftKvvwavxfZL29m9F73wSTjH0KqZ4e0BBOlgsbJdXl
         S8ew==
Received: by 10.236.161.73 with SMTP id v49mr7471251yhk.89.1338824171297; Mon,
 04 Jun 2012 08:36:11 -0700 (PDT)
Received: by 10.146.150.18 with HTTP; Mon, 4 Jun 2012 08:35:50 -0700 (PDT)
In-Reply-To: <1338748217-16440-4-git-send-email-Lucien.Kong@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199142>

On Sun, Jun 3, 2012 at 2:30 PM, Kong Lucien <Lucien.Kong@ensimag.imag.f=
r> wrote:
> Add new informative help messages at the output of 'git status' when
> the user is splitting a commit. The code figures this state by
> comparing the contents of the following files in the .git/ directory:
> =A0 =A0 =A0 =A0 =A0- HEAD
> =A0 =A0 =A0 =A0 =A0- ORIG_HEAD
> =A0 =A0 =A0 =A0 =A0- rebase-merge/amend
> =A0 =A0 =A0 =A0 =A0- rebase-merge/orig-head
>
> Signed-off-by: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
> Signed-off-by: Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>
> Signed-off-by: Jonas Franck <Franck.Jonas@ensimag.imag.fr>
> Signed-off-by: Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
> Signed-off-by: Nguyen Huynh Khoi Nguyen <Huynh-Khoi-Nguyen.Nguyen@ens=
imag.imag.fr>
> Signed-off-by: Moy Matthieu <Matthieu.Moy@grenoble-inp.fr>
> ---
> The second test added by this patch fails because the case in which
> the user amend the last commit through rebase -i is not taken care of=
=2E
> We infer that the user would directly run "git commit --amend" instea=
d
> of amending it with a rebase -i.


Maybe this is safe and logical for most workflows, or maybe this is a
convenience that makes this patch possible (I did not read the patch
yet).  But I know that I sometimes use rebase-i instead of
commit--amend because I did not realize the patch I am fixing is the
most recent one until after continuing, or because the patch I am
amending was moved into the most-recent position during the rebase-i
itself.

Just a note to consider, in case this decision was made arbitrarily.

Thanks for looking after these kinds of corner cases.

Phil
