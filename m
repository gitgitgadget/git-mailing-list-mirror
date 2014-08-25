From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] Makefile: use `find` to determine static header
 dependencies
Date: Mon, 25 Aug 2014 14:27:06 -0700
Message-ID: <20140825212705.GU20185@google.com>
References: <20140822042716.GE27992@peff.net>
 <20140822043303.GB18192@peff.net>
 <20140825194641.GS20185@google.com>
 <20140825200042.GJ30953@peff.net>
 <20140825204516.GT20185@google.com>
 <xmqqppfol1sx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 23:27:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XM1nK-0003N6-4r
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 23:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756619AbaHYV1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 17:27:13 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:58930 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756618AbaHYV1J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 17:27:09 -0400
Received: by mail-pd0-f173.google.com with SMTP id w10so20622165pde.18
        for <git@vger.kernel.org>; Mon, 25 Aug 2014 14:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Pjf+UMF3x5biISCDjFYaznZ1kDmilNfkUuxBc7pNd8s=;
        b=txs89iXVnh9xVi21U6vlvQJZoYPtsmKyZdyAGTOZI9gJxHFxvUHsAhz2R9xwYDdyF9
         I2lOZDBwHDExcn8yR9CU6IiELHHT8EDdYiexAJgJcJUOjWsqsl7JMqPTLQ93UDQoeG7B
         8MHYhXBLPZf8qQ9AlQqSx33gPg82Ywfxyv+Dc2jFMSkqL2Rc50mJzbXmfeqiJ3hPeDsk
         /6aBQkCDWLwv9iDtQFCAioQfc6X76nQ5C2Tan9F7WZRvXv9+X9BcbsNO6apFx4tvgWxu
         hpEDdreanc59zLAy+GCPCRILxQiMXsf1bK+GYqc1XSEaOztrjWqYSObB9IUFWf2z8JPF
         hObA==
X-Received: by 10.68.190.229 with SMTP id gt5mr31620226pbc.15.1409002029076;
        Mon, 25 Aug 2014 14:27:09 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:5425:d689:6054:193])
        by mx.google.com with ESMTPSA id i8sm805357pbq.17.2014.08.25.14.27.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Aug 2014 14:27:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqppfol1sx.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255871>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Tiny nit: I might use
>>
>> 	$(shell $(FIND) * \
>> 		-name . -o
>> 		-name '.*' -prune -o \
>> 		-name t -prune -o \
>> 		-name Documentation -prune -o \
>> 		-name '*.h' -print)
>>
>> or
>>
>> 	$(shell $(FIND) * \
>> 		-name '.?*' -prune -o \
>> 		-name t -prune -o \
>> 		-name Documentation -prune -o \
>> 		-name '*.h' -print)
>>
>> to avoid spending time looking in other dot-directories like .svn,
>> .hg, or .snapshot.
>
> Wouldn't it be sufficient to start digging not from "*" but from
> "??*"?

Gah, the * was supposed to be . in my examples (though it doesn't
hurt).

> 	find ??* \( -name Documentation -o -name .\?\* \) -prune -o -name \*.h

Heh.  Yeah, that would work. ;-)
