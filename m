From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Git Smart HTTP using Nginx
Date: Thu, 10 Mar 2016 15:07:14 +0100
Message-ID: <1457618834.11765.12.camel@kaarsemaker.net>
References: <56E1730D.4030603@benmezger.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Ben Mezger <me@benmezger.nl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 15:07:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae1FL-0004z1-MM
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 15:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbcCJOHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 09:07:20 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34037 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbcCJOHS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 09:07:18 -0500
Received: by mail-wm0-f41.google.com with SMTP id p65so30159752wmp.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 06:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pfyShyZ8dV4f3kHbuv1jCePkZFAYyRIxqe2iQdp1kfY=;
        b=noS/njSb8sHZC4aQt4f9NjiHqZxepxhN/tdxQZQHSa4DSkoDG7cpZx1BbcltjY9w0v
         cccpxHkzviJwTMUfT+79tM1UUblSP8dEidu1ehxq+KeIn4jyogqKsA8Prswbo6sQlErX
         7aAU72JsYnMtT6xmDvM6O257VNU4Th+eUo2clfZSx1gV+EXljfWebUl+L87oqkfvTzyR
         Usib39W2Q+63S8Hi8wDMZc/1NPfb3giCOsPye1mrFzHANONUoQdCIK0B36dl0UAXvwKw
         23/ZEWvMmI2gzS3OHgJktYD1biwZNwMIGi9oX0z3h3DK09SLE0GABzBFTjAPVl9BtkLB
         aB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pfyShyZ8dV4f3kHbuv1jCePkZFAYyRIxqe2iQdp1kfY=;
        b=TpO3M7ASG9nSzGFzLh/x3IQHRrl9zCEZeSWvedVxvFBBCp2Z/bKkb8+ImnqmxPToCy
         TKfaJQn+IkR3mfgtrTNAtoEf2O8EgZBWck1b3cG4dOOXW48mhOFw6PgTR+PdreZCLJdE
         OyPP8XsEV6VLrnLBl8ew2aqWbQQEQn6mefkmcOrwzoJtH0jB0E2gPZua75kz0Qq3WLEj
         VkxVxeGGMKDig/KaOmvqLVs3XUCdIR1xZQfeaxaMGygrhEAb4BOpLJxIa02Ii/uyhILN
         eC93bpv87A9ZUcQr9NEvyH1Lw1U+NjNLtVuUp/4q+2xjdQdffXSJQQWHEJlqoyBvj1yz
         FuoA==
X-Gm-Message-State: AD7BkJLiOPh5m7e66WN/VxV4u8UkMFze3JJh/FZYdAK9NIVO2/r2wG+NBJ6PiTCji/n0/w==
X-Received: by 10.28.51.9 with SMTP id z9mr3951688wmz.59.1457618836945;
        Thu, 10 Mar 2016 06:07:16 -0800 (PST)
Received: from seahawk.local (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id cb2sm3737392wjc.16.2016.03.10.06.07.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Mar 2016 06:07:15 -0800 (PST)
In-Reply-To: <56E1730D.4030603@benmezger.nl>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288624>

On do, 2016-03-10 at 10:13 -0300, Ben Mezger wrote:

> The git-scm.com only uses apache2 as an example of setting Git's
> Smart
> HTTP, and searching the web for the Nginx's config only gives me old
> configs or not-functional configurations. Has anyone managed to get
> Smart HTTP to work with Nginx and could give me a sample of the
> .conf?

This works for me, using fcgiwrap:

    location ~ ^.*/(HEAD|info/refs|objects/info/.*|git-(upload|receive)-pack)$ {
        fastcgi_pass unix:/var/run/fcgiwrap.socket;
        fastcgi_param SCRIPT_FILENAME   /usr/lib/git-core/git-http-backend;
        fastcgi_param PATH_INFO         $uri;
        fastcgi_param GIT_PROJECT_ROOT  $repo_root;
        fastcgi_param REMOTE_USER $remote_user;
        include fastcgi_params;
    }

-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
