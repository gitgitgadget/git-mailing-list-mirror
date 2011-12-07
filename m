From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 0/4] Re: commit: honor --no-edit
Date: Wed, 7 Dec 2011 08:42:17 -0600
Message-ID: <20111207144217.GA30157@elie.hsd1.il.comcast.net>
References: <4EDDD0E4.6040003@st.com>
 <87fwgxwvn9.fsf@gmail.com>
 <7vobvlfowk.fsf@alter.siamese.dyndns.org>
 <7vk469fm9j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Vijay Lakshminarayanan <laksvij@gmail.com>,
	Viresh Kumar <viresh.kumar@st.com>,
	Shiraz HASHIM <shiraz.hashim@st.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 15:42:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYIhb-0005Y9-PM
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 15:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756187Ab1LGOm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 09:42:27 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:32970 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755798Ab1LGOm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 09:42:26 -0500
Received: by qadb40 with SMTP id b40so3377245qad.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 06:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=m5V4f4lvf/QAAvNlQA2Tr13W2FEe/RA4rI81xTbZg4Y=;
        b=J2cKCnfBpktekCdG2zBDYYK/4634XdJWf6LEalx23mGnyscZAq0xs5GcNvdoSQ9ZOv
         amiCzaAE2kwD/N6ES27S6JK+GOHFlAW0h9FlAn4P2F7A4zl0Bsd/50T8dvgdJTAP3Aj5
         zPS3VPRdimfQW8CDpmkvdOaMvzVDRuOTuFlc0=
Received: by 10.50.51.234 with SMTP id n10mr19826045igo.10.1323268945919;
        Wed, 07 Dec 2011 06:42:25 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id df6sm351735ibb.1.2011.12.07.06.42.24
        (version=SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 06:42:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vk469fm9j.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186456>

Junio C Hamano wrote:

> And this should fix it (only lightly tested).
>
> -- >8 --
> Subject: [PATCH] commit: honor --no-edit
>
> After making fixes to the contents to be committed, it is not unusual to
> update the current commit without rewording the message. Idioms to do
> tell "commit --amend" that we do not need an editor have been:
>
>     $ EDITOR=: git commit --amend
>     $ git commit --amend -C HEAD
>
> but that was only because a more natural
>
>     $ git commit --amend --no-edit
>
> did not honour "--no-edit" option.    

I like it.

Here are a couple of tests.  The three patches before are just to make
it less frightening to add to the relevant test script.

Jonathan Nieder (4):
  test: add missing "&&" after echo command
  test: remove a test of porcelain that hardcodes commit ids
  t7501 (commit): modernize style
  test: commit --amend should honor --no-edit

 t/t7501-commit.sh |  335 ++++++++++++++++++++++++++++-------------------------
 1 files changed, 175 insertions(+), 160 deletions(-)
