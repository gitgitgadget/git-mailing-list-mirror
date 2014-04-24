From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v7 12/12] cherry-pick: copy notes and run hooks
Date: Thu, 24 Apr 2014 18:37:44 -0500
Message-ID: <5359a048691f5_523614ed2ecd3@nysa.notmuch>
References: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
 <1398307491-21314-13-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0=AywuFd1xaO3iXudhmnN1Sx2RDvhzmxLBjdaYD4OUB8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 01:48:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdTNJ-0003gC-NT
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 01:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927AbaDXXsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 19:48:13 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:50258 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbaDXXsM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 19:48:12 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so3471319oah.10
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 16:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=3ze0D3vNXeuqIw38MHa4sfKHDHZXMsFXGeOnhqU8M+g=;
        b=lq5vYqCDriYRAnsiEXbagzdy1+ztpIwxfcJTRDnazxVPaEMX2zBJAus3OfCBLaBfMu
         cVpDUirrHlDMn3al57OoI3x1tnQFyBqd4lEFG6CwPNGyxtpGit9/EpIpfmN/a6fNF2lN
         i+XJTYZBMfStgOE7IJuHxUteU3NWn3WF3CE6uONKtUHzywPXgClQvWLFt43xQpKTk9BK
         G3NRuIkpO4c2gBodjnykIfaBSmxyuRn0QuL32KhLjOQt61SWW1TT+Mzdk4P21f7dR6dF
         2KomYB3yNmXUXsyXQvdyiNEl8ndRXDHcVM+f7EjP2mTA9Ei2XmpHGtYNNWRqsHBSTO4K
         9RVA==
X-Received: by 10.60.16.103 with SMTP id f7mr4009008oed.8.1398383291715;
        Thu, 24 Apr 2014 16:48:11 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id 10sm11690055obq.18.2014.04.24.16.48.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Apr 2014 16:48:10 -0700 (PDT)
In-Reply-To: <CALkWK0=AywuFd1xaO3iXudhmnN1Sx2RDvhzmxLBjdaYD4OUB8w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247027>

Ramkumar Ramachandra wrote:
> Felipe Contreras wrote:
> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index 43631b4..fd085e1 100644
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -248,7 +248,7 @@ pick_one () {
> >
> >         test -d "$rewritten" &&
> >                 pick_one_preserving_merges "$@" && return
> > -       output eval git cherry-pick "$strategy_args" $empty_args $ff "$@"
> > +       output eval git cherry-pick "--action-name ''" "$strategy_args" $empty_args $ff "$@"
> 
> Passing an empty action-name looks quite ugly. Is there a better way
> to achieve this?

I want `git cherry-pick` to be able to do two things:

1) Omit the whole notes and hooks code
2) Specify a name other than "cherry-pick" to use for those

The --action-name argument achieves both.

-- 
Felipe Contreras
