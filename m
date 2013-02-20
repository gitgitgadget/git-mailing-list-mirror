From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH] Bugfix: undefined htmldir in config.mak.autogen
Date: Wed, 20 Feb 2013 09:22:35 +0100
Message-ID: <512487CB.3050908@gmail.com>
References: <1be0a520b99fbfecd7255c1d26753015612856b3.1361272864.git.worldhello.net@gmail.com> <7v8v6j52qf.fsf@alter.siamese.dyndns.org> <7v4nh750v3.fsf@alter.siamese.dyndns.org> <CANYiYbF0C2qormAWNVhHm45TVQ6woECD7u1cCxxNuwyZxziNpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Christoph J. Thompson" <cjsthompson@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 09:23:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U84xJ-0005KJ-9m
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 09:23:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933953Ab3BTIWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 03:22:45 -0500
Received: from mail-ee0-f54.google.com ([74.125.83.54]:48882 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933652Ab3BTIWo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 03:22:44 -0500
Received: by mail-ee0-f54.google.com with SMTP id c41so3777838eek.27
        for <git@vger.kernel.org>; Wed, 20 Feb 2013 00:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=8M9MJcgGAqH/RjPlmojFjNftyAUJrv9i49euXq93e8s=;
        b=cyEM/ooUZa67l0T5bYNxeARZ+Nt/5r7su3ugzK0UFTrGZYmzP9wtT56e0/j6+laD6Z
         pRUcCwCAkjMlXPvoEP39JTSJu0MLurXi35tlfwmsxbD5GYZlpQCfEy+zj1feNCWNwk3k
         oAGv0+XQq13L77uG7z+2AhCLaOD8VpfrkaWUj0uzIOCPsc8WdbqsnTfZN+rA2EICaPFh
         XX7sfgrkcPcUoAab1dZfLkUdI8eE8rYt17h2NQOagPCmWSpJz5Yz0qBwVm0sOrMB3lES
         gPPZhO9H8trDeiVQpAxURueIW3TWiaZL2CrqFeMJKIyMb4lLFX3JeC17mkYnwGjioRYh
         NFcA==
X-Received: by 10.14.223.69 with SMTP id u45mr66383613eep.23.1361348563422;
        Wed, 20 Feb 2013 00:22:43 -0800 (PST)
Received: from [192.168.178.20] (host137-94-dynamic.4-87-r.retail.telecomitalia.it. [87.4.94.137])
        by mx.google.com with ESMTPS id 44sm107906806eek.5.2013.02.20.00.22.41
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Feb 2013 00:22:42 -0800 (PST)
In-Reply-To: <CANYiYbF0C2qormAWNVhHm45TVQ6woECD7u1cCxxNuwyZxziNpw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216692>

On 02/20/2013 02:39 AM, Jiang Xin wrote:
>
> [SNIP]
> 
> I am not familiar with autoconf. After clone autoconf and check,
> I cannot find a neat way to change "htmldir" default location to
> use ${datarootdir} (just like mandir).
>
This one-line change should be enough to do what you want:

  diff --git a/configure.ac b/configure.ac
  index 1991258..2bfbec9 100644
  --- a/configure.ac
  +++ b/configure.ac
  @@ -149,6 +149,8 @@ AC_CONFIG_SRCDIR([git.c])
   config_file=config.mak.autogen
   config_in=config.mak.in

  +AC_SUBST([htmldir], ['${datarootdir}'])
  +
   GIT_CONF_SUBST([AUTOCONFIGURED], [YesPlease])

   # Directories holding "saner" versions of common or POSIX binaries.

Not sure whether this a good idea though (I haven't really followed the
discussion); but it is easily doable.

HTH,
  Stefano
