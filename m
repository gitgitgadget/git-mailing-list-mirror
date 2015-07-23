From: David Aguilar <davvid@gmail.com>
Subject: Config variables and scripting // was Re: [RFC/PATCH] log: add
 log.firstparent option
Date: Wed, 22 Jul 2015 21:40:10 -0700
Message-ID: <20150723044007.GA3651@gmail.com>
References: <20150723012343.GA21000@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Josh Bleecher Snyder <josharian@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 23 06:40:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZI8Iu-0001OJ-19
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 06:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbbGWEkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 00:40:15 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34238 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbbGWEkO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 00:40:14 -0400
Received: by pdbbh15 with SMTP id bh15so104668933pdb.1
        for <git@vger.kernel.org>; Wed, 22 Jul 2015 21:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=3J1sxNQTE6/CRuGNlArT8uHuHQQ7LoflUw8UEtdEvZw=;
        b=aYXwkCXC3PGThovmXXh8xWVeS3oEaFDI3vVs+vzkkXAktCUEKeWlR7oQAzsAyorGBe
         STX2HCRgpV65K+DVcz1TJy5pLrGWzZHLZo0JJmu6vD39D6bISNmt6Id0CbKRa74CgwRI
         oxzm0G7CoggY/6q8c2X1UloR6sE+MSz5PNLD+TkvxSG+TArrpQ3x/76ta9CTz94MoYLX
         SSr9OnKUKVNBg+v0sT9xl8g+/RohpzS6pfKCUQTKIjEa8JvTDkxHD1m/91T2oekVqP6w
         DVbygwInSvpA4c2TFLlmW21Y95AdlH3kBnZdwcxHzFfkRtUMGv5RvxQeQJbCBf+tW9DG
         bLfg==
X-Received: by 10.66.255.67 with SMTP id ao3mr13992148pad.60.1437626413385;
        Wed, 22 Jul 2015 21:40:13 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id fl3sm6123384pdb.30.2015.07.22.21.40.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2015 21:40:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150723012343.GA21000@peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274476>

On Wed, Jul 22, 2015 at 06:23:44PM -0700, Jeff King wrote:
> This patch adds an option to turn on --first-parent all the
> time, along with the corresponding --no-first-parent to
> disable it.

[Putting on my scripter hat]

I sometimes think, "it would be really helpful if we had a way
to tell Git that it should ignore config variables".

This is especially helpful for script writers.   It's pretty
easy to break existing scripts by introducing new config knobs.

For example, "user.name" and "user.email" can be whitelisted by
the calling script and and everything else would just use the
stock defaults.

That way, script writers don't have to do version checks to
figuring out when and when not to include flags like
--no-first-parent, etc.

Would something like,

	GIT_CONFIG_WHITELIST="user.email user.name" \
	git ...

be a sensible interface to such a feature?
-- 
David
