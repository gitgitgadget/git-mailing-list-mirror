From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 11/11] Unify appending signoff in format-patch, commit
 and sequencer
Date: Mon, 11 Feb 2013 01:00:09 -0800
Message-ID: <20130211090009.GR15329@elie.Belkin>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
 <1359335515-13818-12-git-send-email-drafnel@gmail.com>
 <20130128033921.GP8206@elie.Belkin>
 <CA+sFfMduqEJPtDQyTe2n7QiLmDpTN7MzLGrUNf1hWf-h0rGzvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 10:00:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4pFj-0005cs-Ug
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 10:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020Ab3BKJAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 04:00:19 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35895 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779Ab3BKJAS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 04:00:18 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so2971573pab.5
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 01:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=o2AFVM2mJm/mZRqMMM/WIbRsC2Y1EbXiYuY2ddE+4AY=;
        b=rG9+dtK0/Hm+m/9coHzvK9TJrLfmRiWtJNw+T8UkkTR++EJmOosJKu12xsRhLQmF/W
         jR6Kj534gUMTZ3/uNunPnWberbejryN+U8QfoMH/llR54LniaVleQxwrvX9pVQMP5O4u
         AJ46Y9JllrfcDk/2EumJ1tyEepQP5fXplx+tQVExeg4c4ovdepOZilHUDi3AeGk6V+ZZ
         jk1my78qmVKtDnddyqcM96+LwWZy2dN82+BqsbLqL8EkuFchtWAnwtz5h0Ak1lLZPodC
         MqZrIbjnW0kFicuYYhYsjR8CPB1X4vLVJLzt7kMD8VnV8YGVyY+QCG1BLLc7ZieT3z/t
         uedQ==
X-Received: by 10.68.132.193 with SMTP id ow1mr16662282pbb.96.1360573217524;
        Mon, 11 Feb 2013 01:00:17 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id wx2sm7042406pbc.42.2013.02.11.01.00.14
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Feb 2013 01:00:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+sFfMduqEJPtDQyTe2n7QiLmDpTN7MzLGrUNf1hWf-h0rGzvA@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216026>

Brandon Casey wrote:

>                            We want to be able to support lines that do
> not have email addresses on the right-hand side like:
>
>    Bug: XXX
>    Change-Id: XXX

Good call.

By the way, regarding what the right "--signoff" behavior is for
commit, cherry-pick, am, and format-patch:

I think the best behavior would be to check if the last signed-off-by
line (ignoring acked-by, bug, change-id, and so on lines that follow
it) matches the one to be added, and if it doesn't, add a new
sign-off.  That way, the sign-off list still would accurately describe
the path of the patch, without silliness like

	Signed-off-by: me
	Reviewed-by: someone
	Signed-off-by: me

that you mentioned.

I agree that that's orthogonal to this series and just mostly
preserving behavior (as you already do) is the right thing to do.

Thanks for noticing the edge cases.

Jonathan
