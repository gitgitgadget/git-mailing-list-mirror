From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] for-each-ref: introduce %(upstream:track[short])
Date: Fri, 27 Sep 2013 20:03:35 +0530
Message-ID: <CALkWK0noW8iJWZan6EpX3Qar866AKm-HUGqWE_U9JubSmWu0yQ@mail.gmail.com>
References: <1380283828-25420-1-git-send-email-artagnon@gmail.com>
 <1380283828-25420-4-git-send-email-artagnon@gmail.com> <52459570.4030301@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Sep 27 16:34:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPZ7g-0000SY-Qd
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 16:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946Ab3I0OeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 10:34:18 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:37179 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939Ab3I0OeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 10:34:16 -0400
Received: by mail-ie0-f179.google.com with SMTP id e14so3982683iej.24
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 07:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=S8fRYZuWI8+q7uT973/uH95dW4hleGBlFkYDGqH0rhE=;
        b=O5qkE4aYlLpxHZL8XdVuCqzqhbIjdfiih0vvsPMA5Yv2429NTbdEX7Gs8AVY6LuHDG
         GOZYLV13qboTcfwSxxjAPMyCSCkLyGyEw+vQ5eBIyH1LUVAVoIs/ouGq3L31Eq3Gd4gr
         1oRQazdUk1SK2J1yKl9Dy0sT9ozwngl1JE5VWVnmpok9eZGMuD8E2xeEQ/2JXRK9Qsbt
         zkbla2h72H5kNXa9ngpenVWfkH49FkE74FSo12enEKVOPEC6fKRQSrO1g6ahjr8HmQwl
         NXitRAHRyJltRT1JkXIHKY72TSfk23bEEdL3/SezufqLI4e55uNltlatBLbrSlIHFM3U
         fz9Q==
X-Received: by 10.50.73.74 with SMTP id j10mr2547847igv.50.1380292455258; Fri,
 27 Sep 2013 07:34:15 -0700 (PDT)
Received: by 10.64.73.36 with HTTP; Fri, 27 Sep 2013 07:33:35 -0700 (PDT)
In-Reply-To: <52459570.4030301@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235465>

Johannes Sixt wrote:
>> +                             else if (!num_ours) {
>> +                                     sprintf(buf, "[behind %d]", num_theirs);
>> +                                     v->s = xstrdup(buf);
>> +                             } else if (!num_theirs) {
>> +                                     sprintf(buf, "[ahead %d]", num_ours);
>> +                                     v->s = xstrdup(buf);
>> +                             } else {
>> +                                     sprintf(buf, "[ahead %d, behind %d]",
>> +                                             num_ours, num_theirs);
>> +                                     v->s = xstrdup(buf);
>> +                             }
>
> These strdupped strings are leaked, right?

Yes, there's a minor leakage; there are quite a few instances of this
in the rest of the file. Do you see an easy fix?
