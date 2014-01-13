From: Maxime Coste <frrrwww@gmail.com>
Subject: Re: [PATCH] git-p4: Do not include diff in spec file when just
 preparing p4
Date: Mon, 13 Jan 2014 12:10:11 +0000
Message-ID: <20140113121011.GA9711@nekage>
References: <20140110181807.GA29164@nekage>
 <20140112222946.GA13519@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Jan 13 13:08:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2gJl-0003z1-0f
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jan 2014 13:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbaAMMIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 07:08:18 -0500
Received: from mail-we0-f182.google.com ([74.125.82.182]:47112 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbaAMMIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jan 2014 07:08:16 -0500
Received: by mail-we0-f182.google.com with SMTP id w62so1248148wes.41
        for <git@vger.kernel.org>; Mon, 13 Jan 2014 04:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jLFWznmOT/HOs5/G77suoXUCFAwPygT2ltD2ChXxMaQ=;
        b=B9mrUOhOF6Cr3u5nTlHTV8KtDXn52ePokULoB6zLLnRVKgnrexnpqKMohtQIIKeBIB
         O7PSX5yTqtOzj6MWKsEQKcJ8UapBV9XNfGVKAI7r4e/H3WmkLLDCQeEPlshtrW6ZCsWr
         rk2HZ8bCUkKe4OGfcORqtw3sVyhLjaCOtw6+GDaAVcJAANiRqc+ZELvhOhdsK9jc0q2T
         oWljcK3ML/lVj7urv3YpCtPsiel8/SCY8nK0y7uLdXH+/zzA5y9TLpcan3bjD2B2YxhM
         KyRBo/4NfRhTBneyIXvt4SHOsDPikB/8QerkjTPMCZWuaNUyWa+mscLmYxBSkIbQg55s
         DMCw==
X-Received: by 10.180.149.238 with SMTP id ud14mr9438273wib.16.1389614895507;
        Mon, 13 Jan 2014 04:08:15 -0800 (PST)
Received: from localhost ([89.100.253.33])
        by mx.google.com with ESMTPSA id w1sm17521615wib.6.2014.01.13.04.08.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jan 2014 04:08:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140112222946.GA13519@padd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240359>

Hello,

On Sun, Jan 12, 2014 at 05:29:46PM -0500, Pete Wyckoff wrote:
> Thanks for the patch, but I'm curious how you'd like this to
> work.  I never use the option myself.
> 
> As it is, --prepare-p4-only generates a file in /tmp/ that has
> exactly the contents you'd see in the editor during "git p4
> submit".  It includes the diff of the change, presumably to help
> with writing the description.

Yes, I believe it makes sense to display the diff in this case, as we
can remove it later programmatically.
 
> Now you can't actually feed this file directly to "p4 submit"
> without deleting the diff.  That's the part you don't like?

Yes, I do not use that for submitting, but for shelving. I can run
git p4 submit --prepare-p4-only followed by p4 shelve -i < /tmp/...
and perforce will shelve the corresponding change.

Removing the diff could be done externally, however git-p4 itself
tells the user it can submit using the generated file, which is
not the case if we keep the diff in it.

Cheers,

Maxime Coste.
