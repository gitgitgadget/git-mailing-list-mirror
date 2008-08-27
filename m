From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: [JGIT PATCH 1/2] Ignore unreadable SSH private keys when autoloading
 identities
Date: Thu, 28 Aug 2008 01:26:25 +0200
Message-ID: <48B5E2A1.3030007@gmail.com>
References: <1219878126-18622-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 01:27:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYUQK-00075R-Tt
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 01:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbYH0X0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 19:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753760AbYH0X0c
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 19:26:32 -0400
Received: from mu-out-0910.google.com ([209.85.134.188]:41978 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069AbYH0X0b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 19:26:31 -0400
Received: by mu-out-0910.google.com with SMTP id g7so71822muf.1
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 16:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=jaUycnsjzv2mE5JMBBU8osuHO7AuVMs95/qoR2EGByA=;
        b=tNxOClg2w3NkqHlMNrEabPt3BVeXzgXXivfX/zelYfNMVYFgxXYlYLXaeSBzo/qrRJ
         TIV2sCISZ9CRgo3UEXgy0qWQy+0NpQemOsD7V2mfvGbUyS6a3kb7jggWw/uiX9WG2aOL
         KxM1CbaClI+GP9bOaj0K/7d2zBeGnVXOaqP8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=gnu+ddWu05vWny8GFMLeCkmXSVOmDrK6S/3VZAQuQW9nczLRYD7miYrL7/bl16LDlr
         Ts2cLGTCcSQzaeeyBmBvvF9MYz0nkU/MGYKjtwCLWpPeV4TqFPVbXkCLcHCbVvPeINBx
         2zcvV4muYNy41T+8f9rHdHwgY+ELE8N5FIRC0=
Received: by 10.103.203.15 with SMTP id f15mr398010muq.0.1219879590529;
        Wed, 27 Aug 2008 16:26:30 -0700 (PDT)
Received: from ?62.21.4.140? ( [62.21.4.140])
        by mx.google.com with ESMTPS id b9sm322127mug.13.2008.08.27.16.26.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Aug 2008 16:26:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080702 Iceape/1.1.11 (Debian-1.1.11-1)
In-Reply-To: <1219878126-18622-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93982>

Shawn O. Pearce wrote:
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
(...)
> +			try {
> +				addIdentity(k);
> +			} catch (JSchException e) {
> +				if (e.getMessage().startsWith("invalid privatekey: "))
> +					continue;
> +				throw e;
> +			}

That's extreme error handling with JSch;) Do you really think it's 
better to rely on internal error message instead of continuing in any 
case? Which other exceptions we would like to pass level up?

-- 
Marek Zawirski [zawir]
marek.zawirski@gmail.com
