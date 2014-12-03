From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/14] strbuf: introduce strbuf_prefixf()
Date: Wed, 3 Dec 2014 12:14:16 -0800
Message-ID: <20141203201416.GY6527@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
 <20141203051016.GK6527@google.com>
 <CAPig+cS6Z=UW80sn6ru15W29Vko-f2g4CUq0EQtWGU7ZjoJcog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 21:14:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwGJd-0000Ak-B1
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 21:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbaLCUOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 15:14:21 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:53771 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbaLCUOV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 15:14:21 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl2so17437811igb.17
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 12:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=91ySekT5ESfxgzLt6uw6mipdWkd9iyoSQA7Zs3Am1gs=;
        b=ywbpn+L6fbOS5DEvz0yiIWGempcS8FXG/rnx+PDI53m+z5O0OE3ku1c9PQU9YSpYmn
         fwaPLWuX0yEcesyeRrtBE45sM4tNPtHCNcedDi2YCAxdtTQF/UUnpq7JWqer6sCAZhpM
         BoKS3F347lOC3pFF3EaG8pdUNxp3pRFLYBjjyUF+I2I1BqL0B8CKqE7YsbUAsY/BhZ8S
         8m8DmgzZjemeXO1OVz6ezX2eNdZg5NgvseBoe31917tXOayBVYRtFx5P5oZy7hTCdy6i
         iSVPObiZvv4m3ojhojmReaVv/dBLG2wyHiZ0HmEa+YmxsJth6h89WKWT68nMV4I3JcJj
         Vj/w==
X-Received: by 10.107.40.16 with SMTP id o16mr6619638ioo.26.1417637660251;
        Wed, 03 Dec 2014 12:14:20 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id 6sm7325090igk.11.2014.12.03.12.14.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Dec 2014 12:14:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAPig+cS6Z=UW80sn6ru15W29Vko-f2g4CUq0EQtWGU7ZjoJcog@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260685>

Eric Sunshine wrote:
> On Wed, Dec 3, 2014 at 12:10 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> +void strbuf_prefixf(struct strbuf *sb, const char *fmt, ...)
>> +{
>> +       va_list ap;
>> +       size_t pos, len;
>> +
>> +       pos = sb->len;
>> +
>> +       va_start(ap, fmt);
>> +       strbuf_vaddf(sb, fmt, ap);
>> +       va_end(ap);
>> +
>> +       len = sb->len - pos;
>> +       strbuf_insert(sb, 0, sb->buf + pos, len);
>> +       strbuf_remove(sb, pos + len, len);
>
> Would a strbuf_setlen(sb, pos), rather than strbuf_remove(), make it
> clearer to the reader that this is merely performing a truncation?

Good idea.  I'll do that.

Thanks,
Jonathan
