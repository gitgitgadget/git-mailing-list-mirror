From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 7/9] parse-options.h: add macros for '--contains'
 option
Date: Tue, 09 Jun 2015 18:19:51 +0530
Message-ID: <5576E0EF.3080301@gmail.com>
References: <5573520A.90603@gmail.com>	<1433621052-5588-1-git-send-email-karthik.188@gmail.com>	<1433621052-5588-7-git-send-email-karthik.188@gmail.com> <xmqqr3pm9et4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 14:50:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Iyk-00007I-Pi
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 14:50:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932969AbbFIMuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 08:50:03 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34216 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932235AbbFIMt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 08:49:57 -0400
Received: by payr10 with SMTP id r10so13389124pay.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 05:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=hxVgx5CfGGFe7OmZplUCGKAe3B9p5v0APQ82nohHZ0Q=;
        b=tFii2hojy3q81ZNCwuHQU+MV8bdeO/+6AbQj+f0+Bvaz4js4ho2Fr6K7ga2U5Br8Ne
         VC43ZD3sg2rYRx4vL15JOtoAplcp//KhOt5NPIHiBInqcratSwpAHTn5OPrBRfhmrkJz
         vV9TJVoDwXf8jRWCqu8CjnOai/Rb9OdnxmIgu9I6vDLW4F4j+8KRvyf+rOe2J1UQ+UEo
         Q3Ni5rA8O5iP16y1qvn1/i6HGQuWPH1VzAGS2NmBVBkeEehSHPigZ/N5o0kuQnBs9hsc
         GjutPiUqw18XzDCTxobEbb3/yk8mVKzqnlUpmgWlLfvYQUNEJ827pkXZRhh5omSrY40K
         y87Q==
X-Received: by 10.68.129.134 with SMTP id nw6mr38322051pbb.109.1433854196841;
        Tue, 09 Jun 2015 05:49:56 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id de2sm5622716pdb.15.2015.06.09.05.49.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 05:49:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqr3pm9et4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271173>

On 06/09/2015 01:02 AM, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +#define OPT_CONTAINS(filter, h) \
>> +	{ OPTION_CALLBACK, 0, "contains", (filter), N_("commit"), (h), \
>> +	  PARSE_OPT_LASTARG_DEFAULT, \
>> +	  parse_opt_with_commit, (intptr_t) "HEAD" \
>> +	}
>> +#define OPT_WITH(filter, h) \
>> +	{ OPTION_CALLBACK, 0, "with", (filter), N_("commit"), (h), \
>> +	  PARSE_OPT_LASTARG_DEFAULT, \
>> +	  parse_opt_with_commit, (intptr_t) "HEAD" \
>> +	}
>
> The redundancy bothers me.  Can't we do a bit better than that,
> perhaps like this?
>
> #define _OPT_CONTAINS_OR_WITH(name, variable, help) \
> 	{ OPTION_CALLBACK, 0, name, (variable), N_("commit"), (help), \
> 	  PARSE_OPT_LASTARG_DEFAULT, \
> 	  parse_opt_with_commit, (intptr_t) "HEAD" \
> 	}
> #define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h)
>

This seems better, thanks!

-- 
Regards,
Karthik
