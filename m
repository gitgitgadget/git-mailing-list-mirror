From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH] Bugfix: undefined htmldir in config.mak.autogen
Date: Wed, 20 Feb 2013 13:30:52 +0100
Message-ID: <5124C1FC.6050004@gmail.com>
References: <1be0a520b99fbfecd7255c1d26753015612856b3.1361272864.git.worldhello.net@gmail.com> <7v8v6j52qf.fsf@alter.siamese.dyndns.org> <7v4nh750v3.fsf@alter.siamese.dyndns.org> <CANYiYbF0C2qormAWNVhHm45TVQ6woECD7u1cCxxNuwyZxziNpw@mail.gmail.com> <512487CB.3050908@gmail.com> <CANYiYbHpEd8kgv2nPvJgDvNLhzHbYJ8uN2gLNWWwCWvrVExpBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Christoph J. Thompson" <cjsthompson@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 13:31:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U88pg-0004E3-WC
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 13:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935114Ab3BTMbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 07:31:08 -0500
Received: from mail-ee0-f41.google.com ([74.125.83.41]:37127 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934929Ab3BTMbH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 07:31:07 -0500
Received: by mail-ee0-f41.google.com with SMTP id c13so4236163eek.28
        for <git@vger.kernel.org>; Wed, 20 Feb 2013 04:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=tQAhLKwAXYXx+77OWWL5mS8AzVUi31FArhdchd/vWSk=;
        b=NMGl/ea8chbk5G8BFgEjFIt59/C0dfzGXOXg2Y69sw/HxrdmE4mVaFXvRGke3bBNJw
         56jfQZ3GmsWrOZwuYOs23ddO5veCl7TZaYFQ9uSgPZ5DaVjgLgC8+CBo+d4T8QrCOozb
         /6tVtL8wd3Z1/fapMQvKv28g7xDOeZUYPXukOsVH6UXVmP3nNOWASLDwGCfVPUQLeWYl
         P5rstxSxyC1+9ptTzEtYq1FnSsc16VcTVjNsLG26qLo6Zqv1kWPRz/jvyR8JFyHBI9p1
         t8WAE1Iw1e3KfLS7oim5mYBTLIq1wQqp9Fi1Kgbx5gV0eGp+gwulUW6QUjxloPoi15LD
         2S2A==
X-Received: by 10.14.214.66 with SMTP id b42mr68699138eep.34.1361363466400;
        Wed, 20 Feb 2013 04:31:06 -0800 (PST)
Received: from [192.168.178.20] (host137-94-dynamic.4-87-r.retail.telecomitalia.it. [87.4.94.137])
        by mx.google.com with ESMTPS id r4sm64658973eeo.12.2013.02.20.04.31.04
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Feb 2013 04:31:05 -0800 (PST)
In-Reply-To: <CANYiYbHpEd8kgv2nPvJgDvNLhzHbYJ8uN2gLNWWwCWvrVExpBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216706>

On 02/20/2013 11:42 AM, Jiang Xin wrote:
>  2013/2/20 Stefano Lattarini <stefano.lattarini@gmail.com>:
>> On 02/20/2013 02:39 AM, Jiang Xin wrote:
>>>
>>> [SNIP]
>>>
>>> I am not familiar with autoconf. After clone autoconf and check,
>>> I cannot find a neat way to change "htmldir" default location to
>>> use ${datarootdir} (just like mandir).
>>>
>> This one-line change should be enough to do what you want:
>>
>>   diff --git a/configure.ac b/configure.ac
>>   index 1991258..2bfbec9 100644
>>   --- a/configure.ac
>>   +++ b/configure.ac
>>   @@ -149,6 +149,8 @@ AC_CONFIG_SRCDIR([git.c])
>>    config_file=config.mak.autogen
>>    config_in=config.mak.in
>>
>>   +AC_SUBST([htmldir], ['${datarootdir}'])
>>   +
>>    GIT_CONF_SUBST([AUTOCONFIGURED], [YesPlease])
>>
> 
> If changed like that, set:
> 
>      AC_SUBST([htmldir], ['${datarootdir}/doc/git-doc'])
> 
> In the generated "configure" file, this instruction will be inserted
> after the option_parse block (not before), and will override what
> the user provided by running "./configure --htmldir=DOCDIR".
>
Yikes, you're right.  Scratch my suggestion then; the issue should
probably be brought up on the autoconf mailing list.  Albeit I think
it is by design that autoconf doesn't let a package to override the
defaults for installation directory: this way, the end users can
expect consistent, well-documented defaults for all autoconf-based
packages.


> BTW, add "docdir = @docdir@" to "config.mak.in", also let
> "./configure --docdir=DIR" works properly.
> 

Thanks, and sorry for the noise,
  Stefano
