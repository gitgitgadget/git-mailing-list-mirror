From: Junio C Hamano <jch@google.com>
Subject: Re: [PATCH v6 4/4] git-rebase: add keep_empty flag
Date: Thu, 19 Apr 2012 10:53:17 -0700
Message-ID: <xmqq7gxbsj5e.fsf@junio.mtv.corp.google.com>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
	<1334686809-17634-1-git-send-email-nhorman@tuxdriver.com>
	<1334686809-17634-5-git-send-email-nhorman@tuxdriver.com>
	<7vmx68k5oy.fsf@alter.siamese.dyndns.org>
	<20120419130818.GA18339@neilslaptop.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Clemens Buchacher <drizzd@aon.at>,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 19:53:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKvXp-0000G0-JM
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 19:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755962Ab2DSRxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 13:53:20 -0400
Received: from mail-wi0-f202.google.com ([209.85.212.202]:57648 "EHLO
	mail-wi0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755415Ab2DSRxT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 13:53:19 -0400
Received: by wibhj13 with SMTP id hj13so113701wib.1
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 10:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Jsop/fy8yzyzyx+M4vSzgYZ3A5HH2u/dtlmNseCgZNw=;
        b=NImz75VXb8VwCn3fHCzepA20LZA0pcCJS+BxAB5fMlFoEnvlgXtsTOuNUs81lJuWyF
         L+tgURaXlBcdlw3iKP4hWRzyXzDUwcgZ+zWWjbDg0eBgVWeCPoxDiXAFt0digwSQw9J0
         2pkYGrrY8N/0wUJgqSqpTiOBQVCpilBjemYPPFPQ4ZGRYtIfK72BEkKhGFUfukia8Y74
         hSCZcPGtiHrnFIwsZ78HBi6tP1PXOegv0QKX5/iNjJw2gbfJ5uKClQ/pNtkfEuFAYGnR
         8Ng2wgiULojc2uOneAqLd/GAoFh3w+tkfevVIw/MpfePv/w8Od08vRoCnEBXkauBGSaJ
         2E/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=Jsop/fy8yzyzyx+M4vSzgYZ3A5HH2u/dtlmNseCgZNw=;
        b=WYDcJK4RqxYkG4LbE0smHuQmTtMNHwTFP04iyTdtDCzfXyhps6hDdGYqApKa6tk2K8
         d2WxY+zmzG+DJBPhzrCWv/yWetA6uvSrFCW8svJ1CRhdSbuwg+xioEDgQ6SDZm7WEzBc
         cL1inN6y/iLVYt4GNhqwGNp+hikCh6qw+QxSYlq18+OsnpxM6NN7Emrb4u8otT1Ah5Pz
         LNDL1+t8BkiCf1QfEAr8TLV7N8lXEeUUkcz+2hmr0gkNY1RfqB6829Zi2qn1ArwJU5vH
         vg74r3xQBmeDbbzWVQiMGzQ+7V0RQU7SEjBijKyFAUMfcJ2xoxVxtSLo0f867ZrMq/C8
         hdIQ==
Received: by 10.14.96.134 with SMTP id r6mr839046eef.1.1334857998682;
        Thu, 19 Apr 2012 10:53:18 -0700 (PDT)
Received: by 10.14.96.134 with SMTP id r6mr839029eef.1.1334857998569;
        Thu, 19 Apr 2012 10:53:18 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id s9si2772155eei.3.2012.04.19.10.53.18
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 19 Apr 2012 10:53:18 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 6057E200057;
	Thu, 19 Apr 2012 10:53:18 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id B5635E554F; Thu, 19 Apr 2012 10:53:17 -0700 (PDT)
In-Reply-To: <20120419130818.GA18339@neilslaptop.think-freely.org> (Neil
	Horman's message of "Thu, 19 Apr 2012 09:08:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQm8HEk6ZG4ewugnATYV/tutt760DYAlKKA3OuZHt6hxB3iP9LlKesNhWSalCTmW027KOALN0b8JHWHWQGtiFmyz9Uvzw1/T8Ng0xYzrb1yemZuSNiRRSYLTFbXZQcfbR9EcLcQ5w/GyMvzbio2PAjjDksDuUZZf38aZOZFr7FqQlUPYeZU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195956>

Neil Horman <nhorman@tuxdriver.com> writes:

>> > +is_empty_commit() {
>> > +	tree=$(git rev-parse "$1"^{tree})
>> > +	ptree=$(git rev-parse "$1"^^{tree})
>> > +	return $(test "$tree" = "$ptree")
>> > +}
>> 
>> Could "$1" ever be a root commit without a parent?
>> 
> Strictly speaking, yes.  If that happens, however, the output of git rev-parse

You do not have to speak strictly to see that bug that surfaces internal
error message leaking to the end user.
