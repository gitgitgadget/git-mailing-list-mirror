From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] ident: support per-path configs by matching the path against a pattern
Date: Fri, 10 Jul 2015 14:07:46 -0700
Message-ID: <xmqqlhenk9gd.fsf@gitster.dls.corp.google.com>
References: <0000014e7752e758-a0bf7acb-2d0f-4492-8004-8eeeb9b2f042-000000@eu-west-1.amazonses.com>
	<xmqqr3ogkpz5.fsf@gitster.dls.corp.google.com>
	<20150710154308.GA29395@peff.net> <20150710164652.GA30113@peff.net>
	<xmqqtwtbkbis.fsf@gitster.dls.corp.google.com>
	<20150710205821.GB1181@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 10 23:08:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDfWY-0007PW-PI
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 23:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933035AbbGJVHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 17:07:50 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:35905 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932476AbbGJVHs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 17:07:48 -0400
Received: by iecvh10 with SMTP id vh10so204345408iec.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 14:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=K+6CijvY/FhvNtmnqcm1CKLr/bB/FSWjoQCo1S8daQY=;
        b=O/TD96ShDC9bDbBcT8fCs3lS089/7El5Cr4moelFh1fZ8QGcqvKpkSrVMUgjwnwaQE
         zHOQQGO1t9hWKEwXz0lWf2x00dOAc4FO1cDPerH0avGxs6AHg2pJo6JOw/600vmenO4F
         Bn5ku8WrCzhhFaJ5avlVGKXqAVgpHOsbpfs6IHHMyyLRy8QyDvhym5yXcq0eP1Nm1ukW
         UccBZxj1X4hJaDwRZHCoz1WTk8V1ufj5Gw2Mt3XPVtSKuWOh+ZlAaX7KTk+BXBPd5/eA
         jEZJC0uw5wN71cBShHvKLdr2FcgyGg/C7yDF4WW9vy5qUvuBUYOZzBVg18on/THqnjJ0
         wDkg==
X-Received: by 10.107.3.33 with SMTP id 33mr7142422iod.132.1436562468241;
        Fri, 10 Jul 2015 14:07:48 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6de3:8019:a2a4:79ec])
        by smtp.gmail.com with ESMTPSA id j20sm362524igt.5.2015.07.10.14.07.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 Jul 2015 14:07:47 -0700 (PDT)
In-Reply-To: <20150710205821.GB1181@peff.net> (Jeff King's message of "Fri, 10
	Jul 2015 16:58:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273837>

Jeff King <peff@peff.net> writes:

> On Fri, Jul 10, 2015 at 01:23:07PM -0700, Junio C Hamano wrote:
>
>> > -	if (!strcmp(var, "include.path"))
>> > -		ret = handle_path_include(value, inc);
>> > +	if (!parse_config_key(var, "include", &cond, &cond_len, &key) &&
>> > +	    include_condition_is_true(cond, cond_len)) {
>> 
>> I really like these two lines.
>> 
>> Whoever designed that parse_config_key() interface either is a
>> genious or had a foresight with a crystal ball, or perhaps both.
>
> Heh. I peeked at the archive, and I think it was actually designed by
> committee. Perhaps we are greater than the sum of our parts? ;)

It does not look like a camel, though ;-).

Thanks.  Let's see if Sebastian finds the direction satisfactory.
