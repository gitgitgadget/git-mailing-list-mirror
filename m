From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v8 1/4] sha1_file.c: support reading from a loose object
 of unknown type
Date: Sat, 18 Apr 2015 14:02:31 +0530
Message-ID: <5532169F.4070709@gmail.com>
References: <552E9816.6040502@gmail.com>	<1429117143-4882-1-git-send-email-karthik.188@gmail.com>	<xmqqmw29jg78.fsf@gitster.dls.corp.google.com>	<20150415221824.GB27566@peff.net> <20150417142310.GA12479@peff.net>	<553154C8.5090001@gmail.com> <xmqqlhhqpnj5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 10:32:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjOB7-0001FI-78
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 10:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbbDRIcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2015 04:32:36 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35100 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbbDRIcf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2015 04:32:35 -0400
Received: by pdbqd1 with SMTP id qd1so152106023pdb.2
        for <git@vger.kernel.org>; Sat, 18 Apr 2015 01:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=qXfvvSdd/tTDjws9vwPK3rIPuFKh/iIIBRaZKauMq/4=;
        b=TZmtaFhqbdqPi+a6wDbGNzlkR92x3CNlGX6tx2ct42iG+y0cG6K79hPB/bvxk/zqOR
         WUqooiQfA9JjYEU92UooP9QMWAtdpuklcbE079SNe2VmJgshawW6f4BS2T2rR28jqSok
         6zD0Bunb5UA+Ppb0TmZ9JlphK0YGyyVHd4bdzwxTreBGk9PMQD/KQmVEYRljois5GmnO
         70otd4d2IKVl5yl6kCjNHIdW1fJ3OVdEvA/WsuC/C+//8wlWnF0T9ydhSpxIhkblWFrC
         BU15gZwL7YTRmzTqAqHNN7yQ+W7lI3/MKBWcuxzr4pq6kV55Ue6izRW9Bn5u8GOUlVYJ
         cWsw==
X-Received: by 10.66.161.161 with SMTP id xt1mr12026530pab.35.1429345954872;
        Sat, 18 Apr 2015 01:32:34 -0700 (PDT)
Received: from [192.168.0.100] ([103.227.98.178])
        by mx.google.com with ESMTPSA id qv9sm12317229pab.27.2015.04.18.01.32.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Apr 2015 01:32:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqqlhhqpnj5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267410>



On 04/18/2015 12:53 AM, Junio C Hamano wrote:
> karthik nayak <karthik.188@gmail.com> writes:
>
>> +       type = type_from_string_gently(buf, len, 1);
>> +       if (oi->typename) {
>> +               strbuf_add(oi->typename, buf, len);
>> +               strbuf_addch(oi->typename, '\0');
>
> add() has setlen() at the end so you do not have to NUL terminate it
> yourself.  Doing addch() is actively wrong, as oi->typename->len now
> counts the terminating NUL as part of the string, no?
>

Yes. was speculative of that. thanks for clearing it up.
