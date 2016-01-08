From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH/RFC v2 3/3] refs: always handle non-normal refs in files
 backend
Date: Fri, 08 Jan 2016 07:52:43 -0500
Organization: Twitter
Message-ID: <1452257563.24133.5.camel@twopensource.com>
References: <567A5516.9070209@alum.mit.edu>
	 <1452123719-22634-1-git-send-email-dturner@twopensource.com>
	 <1452123719-22634-3-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Jan 08 13:52:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHWXC-0002pj-TT
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 13:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763AbcAHMwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 07:52:47 -0500
Received: from mail-qg0-f50.google.com ([209.85.192.50]:33858 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033AbcAHMwq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 07:52:46 -0500
Received: by mail-qg0-f50.google.com with SMTP id 6so272611462qgy.1
        for <git@vger.kernel.org>; Fri, 08 Jan 2016 04:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=28Th2rD1oWrmE/GrdoUWw+f0oaxt5sRyTpe3icU9gx8=;
        b=nDENjxk3iXNcPKpuBrIFSqd1NffpkYwu7K6NIyVuQv6XCtCby8ARrd5HeePOVD4NT/
         pNyFKy1uBHL95sEJPc8TwFESRTbQM+FMttIqlkWmpR0av/LNW0KKY00zHG9913BtIO5D
         2MJxqC5Wj1JBv5DRYoRkZj7smmbzxhnwhKbEcQZHl4vLSVVH3ssNszPa6qv7iDyCK4kF
         ASLAKgNk5/BYaFgI0mkUk8qzmJgCnj/tj91/3jkcHIXM6Y7rJcjHbOq06J44f98SOvAZ
         qjhDU1d5u5aWgbTTLUhz1ij1QgVtRaBx1VubVw4OSmQhn8q6KSEf1TdS4Zwo0gLsgHes
         QY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=28Th2rD1oWrmE/GrdoUWw+f0oaxt5sRyTpe3icU9gx8=;
        b=IdNk8YVcZBEuqnxfVWT7S3c3IHfZ5pk4fD6ArjoWMT6sTBdaIPuNvpvFEMKH3yeihR
         Jtar7W3XfiQopYHgRVjG4B2nKkF+EEVmE+jdheiLSgLK0u/DfvuDGCfFmjZFIHGA6NSZ
         tL7fOsb5Dr+8oMiEcKKakTbOGRUb01jRYZLINMu6KfQZMBhpTAVy6IiTegyFUyBsgsRS
         oo92feW3jtccKPVHiyl5qWNAbXgow29UJ+eg9Z/zxQwNiWb5JSz++AJ8zJsraS0Z19VZ
         1Y725mboSuuT5G2Y9dUD2jljfJU0mJLM3L4bjUSglxPy+WMQjT9MduOXV6A0d0mIY8Ts
         behg==
X-Gm-Message-State: ALoCoQm9rDEmnL68rjfFUQ9Kyr5yCo2/LeAhVyV4KClf5JgF3TN4qVM+eG20SE4p4z1gIwqbCo2puU5F4WyvFieOtbHDBNmelA==
X-Received: by 10.140.217.67 with SMTP id n64mr92489447qhb.26.1452257565607;
        Fri, 08 Jan 2016 04:52:45 -0800 (PST)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id w14sm48292552qge.24.2016.01.08.04.52.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Jan 2016 04:52:44 -0800 (PST)
In-Reply-To: <1452123719-22634-3-git-send-email-dturner@twopensource.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283551>

On Wed, 2016-01-06 at 18:41 -0500, David Turner wrote:
+		files_transaction->updates[files_transaction->nr++]
> = update;

oops, need to allocate this (fixed on my branch).
