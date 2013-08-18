From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: Use OPT_BOOL instead of OPT_BOOLEAN to allow one action multiple times
Date: Sun, 18 Aug 2013 02:27:11 -0700
Message-ID: <xmqqioz3e4cw.fsf@gitster.dls.corp.google.com>
References: <1375207251-4998-1-git-send-email-stefanbeller@googlemail.com>
	<7va9l3x34f.fsf@alter.siamese.dyndns.org>
	<51F83010.2060804@googlemail.com>
	<7vfvuvvg0r.fsf@alter.siamese.dyndns.org>
	<51F8E81E.6000705@googlemail.com>
	<7vbo5itjfl.fsf@alter.siamese.dyndns.org> <520F9051.4040600@gmail.com>
	<20130817203458.GB2904@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 18 11:35:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAzO9-0005z1-Ng
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 11:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633Ab3HRJdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 05:33:04 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:58165 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab3HRJdD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 05:33:03 -0400
Received: by mail-yh0-f74.google.com with SMTP id z20so190052yhz.5
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 02:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=zNynkErC9RwWEobD+qJ5Ig6yESq8EJMg56MniGbWnoU=;
        b=KTEC/oOZqg5v4ONgVkLFEJZfV3OmByt/5JlRV4ag7IrPC5EKtYkhTKNjFcy2XTQhPk
         7SWpAY3Bw2uCbgtUZ0MT3rUHsqqlsUZhFWBT6zX86cVHQMXOOAAwJknYSDGanrwn4XrG
         SrqIbgiqsIZqqnJmQfQTuSLaRQzsTVZxRC7tyJ4I2FhkYbDkezNRL9jLBASZC59HALOz
         +ZCXX3pkq4kfbawAKAiZJaLuJcvhc2XUlE6ofkWHtyLi6AkBc0UNjRaswwjhCxxuWjc1
         GoxGRZkx2PUSG60Et4Pxp2GW2kIV0nMLKPRlDj6RQ+QjO/cvaOGb4a1HWtzP5qUnNgyG
         cqqg==
X-Received: by 10.236.4.69 with SMTP id 45mr2236456yhi.20.1376818031991;
        Sun, 18 Aug 2013 02:27:11 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id g50si390626yhd.0.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Sun, 18 Aug 2013 02:27:11 -0700 (PDT)
Received: from gitster.dls.corp.google.com (gitster.dls.corp.google.com [172.25.228.236])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id CE8DE5A41A0;
	Sun, 18 Aug 2013 02:27:11 -0700 (PDT)
Received: by gitster.dls.corp.google.com (Postfix, from userid 110493)
	id 148EB6BD7D; Sun, 18 Aug 2013 02:27:11 -0700 (PDT)
In-Reply-To: <20130817203458.GB2904@elie.Belkin> (Jonathan Nieder's message of
	"Sat, 17 Aug 2013 13:34:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232472>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Stefano Lattarini wrote:
>
>> Why not encourage the use of a standardized '--action' option instead?
>
> Because it's an unpleasant UI. :)
>
>> This can work with lesser compatibility headaches for both the commands
>> taking mode options and the commands taking mode words:
>>
>>   "git submodule init"   becomes  "git submodule --action=init"
>>   "git tag --delete TAG" becomes  "git tag --action=delete TAGNAME"
>
> That looks like a bad change in both cases --- it involves more
> typing without much upside to go along with it.  But
>
> 	"git submodule init"   gains synonym "git submodule --init"
> 	"git tag --delete TAG" stays as      "git tag --delete TAG"
>
> looks fine to me.

I agree 100% with the above that illustrates why --action=<name> is
a bad idea.  As I already said, adding action-option like --init, if
doing so might help people, I am not opposed to it.

Thanks.
