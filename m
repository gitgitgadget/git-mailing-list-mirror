From: "rae l" <crquan@gmail.com>
Subject: Re: [PATCH 3/3] git-remote: simplifying get_one_entry
Date: Tue, 18 Nov 2008 08:56:12 +0800
Message-ID: <91b13c310811171656v54363993rfe0f149e7d1da0b0@mail.gmail.com>
References: <1226920551-28303-1-git-send-email-crquan@gmail.com>
	 <1226920551-28303-2-git-send-email-crquan@gmail.com>
	 <1226920551-28303-3-git-send-email-crquan@gmail.com>
	 <7vabbywb75.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 01:57:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2EuI-0000iM-II
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 01:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbYKRA4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 19:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbYKRA4P
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 19:56:15 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:43825 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbYKRA4O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 19:56:14 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1306214nfc.21
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 16:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=VsMfyyzIPXHdY0ZaL2DN1BvPcJLec/Lfcr93D9yqsEk=;
        b=TkDr96iekoEoOYgzbKssp2r1ex9sbPCoQ9qrYHWMC1BuwN21E3qgFejyy86M7oO4F5
         ydVpbJ5orLXSXlo2cpKwLaNga0yMJtgp90jArdUs0n8iuYX3jwm7j5qz3/OSv6Da6qtJ
         wRkIocNCiv4MpBI+eB/exc8JqLnJt946q8jd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=m7MKEF51Sh8TzYVNto+89705hVVZ88O4C3Fw5wy2DhqEJ4MCyfrmCQbVj39qGdxYjE
         72gkJa6luY7Un1ABQfOkGMo84QWLfilvhocNaioLR1ao4g6bfy6WDUzH/KY5cICLFWwh
         2KI6fQDQPA6EkwZeyIv1zpxDEX9aQSrwtc/sk=
Received: by 10.103.102.17 with SMTP id e17mr1493582mum.119.1226969772826;
        Mon, 17 Nov 2008 16:56:12 -0800 (PST)
Received: by 10.103.191.7 with HTTP; Mon, 17 Nov 2008 16:56:12 -0800 (PST)
In-Reply-To: <7vabbywb75.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101256>

On Tue, Nov 18, 2008 at 12:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> crquan@gmail.com writes:
>
>> From: Cheng Renquan <crquan@gmail.com>
>>
>> The loop for remote->url_nr is really useless, set to the last one
>> directly is better.
>
> Is it really useless?  Be more descriptive.
>
>> -     if (remote->url_nr > 0) {
>> -             int i;
>> -
>> -             for (i = 0; i < remote->url_nr; i++)
>> -                     string_list_append(remote->name, list)->util = (void *)remote->url[i];
>> -     } else
>> -             string_list_append(remote->name, list)->util = NULL;
>> +     string_list_append(remote->name, list)->util =
>> +             remote->url_nr > 0
>> +             ? (void *)remote->url[remote->url_nr-1] : NULL;
>
> When you have more than one URL associated with the remote (this makes
> sense only for pushing), the current code adds that many string_list_item
> to the list, each holding the URL.  "git remote -v" shows all of them.
>
> Your change instead creates only one string_list_item and hold the last
> URL.  Doesn't it make show_all() to show only one URL for the remote?
Sorry, this patch is totally wrong, I will regenerate the other two and resend.

Thanks for your patience.

-- 
Cheng Renquan, Shenzhen, China
Steven Wright  - "Cross country skiing is great if you live in a small country."
