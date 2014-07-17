From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] abspath.c: use PATH_MAX in real_path_internal()
Date: Fri, 18 Jul 2014 01:03:01 +0200
Message-ID: <53C85625.6020808@gmail.com>
References: <1405601143-31354-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 01:03:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7uhe-0005nH-6I
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 01:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758177AbaGQXDA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2014 19:03:00 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34814 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158AbaGQXDA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 19:03:00 -0400
Received: by mail-wi0-f173.google.com with SMTP id f8so7664595wiw.12
        for <git@vger.kernel.org>; Thu, 17 Jul 2014 16:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=bvHkLw2ACJ20fCW4b+36IqcPWF4787GDbY3zY54UZu0=;
        b=JOfvelziYbikJiglP4UtKDqBtHp5DcIlBEJ2gowQ6869s0gq4k1VAy9Hwq6PfhXj6O
         VyI3l34wuE06FrG7etptP132Z/dsOxHNPUae7Qp8VXv7gajaUdtpQ9SdOkNsjYe4YR9e
         +PgTCccr4D26KYGI/GxZxhFt+SXm69TTN/xF8oQ5TMQUqL4GKplznusolFndfmRLckP/
         Pfk+A6EKXgfL9RYFXLNkXMUFU/Tu1q08J3POMvg2uSJiMLl2LIeEder0zZuBJEWZLtWO
         VyJL1lSLjzXy2An7ZYeNWA4rtIq/Xma8sy7bjAe1TmCC755WvRen9LH7Trpqq+lqWP5Z
         8h7A==
X-Received: by 10.181.11.232 with SMTP id el8mr1837547wid.57.1405638179009;
        Thu, 17 Jul 2014 16:02:59 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ja9sm73457989wic.8.2014.07.17.16.02.57
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Jul 2014 16:02:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1405601143-31354-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253786>

Am 17.07.2014 14:45, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> e.g. "git init". Make it static too to reduce stack usage.

But wouldn't this increase overall memory usage? Stack memory
will be reused by subsequent code, while static memory cannot
be reused (but still increases the process working set).
