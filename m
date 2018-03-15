Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B1E01F404
	for <e@80x24.org>; Thu, 15 Mar 2018 21:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752372AbeCOVFn (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 17:05:43 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44661 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752220AbeCOVFm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 17:05:42 -0400
Received: by mail-wr0-f196.google.com with SMTP id v65so9647514wrc.11
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 14:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=CDbk5ebA6N7yrLfkghCv+7CZTvxI5h0uOOONy1Wc2oo=;
        b=QYq7bQDjy9Z7EUEF+U1XI++TxtBD7k/LjmQqiYQvFjdubyFyZvuoDqwKytasoJl1jI
         anvTibk5/ebTt0MddWfkK8OpAALZDg/THAHyelAYnGNB3Ezi/yj+Cws7hxGNQYuW9tZo
         uKBMnzDvM10Jj+ATf91Y2uroq0Io6yZt52rgLyuHF/g+RxPfBRejHAGf5mYpGFSeKTIk
         b5rObGI+TMo3r42y1RDqqnacoXvLv+eJk5n7cUF2yOjJZ2PMz0rsNbsWwvljelteH2he
         H6PoMLItt3tetEu0MPuxNh3h2yg6eytRRV6WU77B0xpY87QBBs7KgUjBgbmOKofptM8B
         NyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=CDbk5ebA6N7yrLfkghCv+7CZTvxI5h0uOOONy1Wc2oo=;
        b=DbuFZTjUysYTGwnnAVf5Y5C3wn7W6x7C4KH4g+z/rcLNE4UX28wFE4xQT/V0YDA/3l
         r9eWmbj2k1Cm+miFZS//lggVbeJe+Is7Hri6j9JuqAOtKQEECtXiBUdR9PJgPP0fQ+hQ
         7gRI9W3u62/4zCKWAHAxzz4kC4VDz+2uBtHeksaBOIAnTizoLfMe6lakgCOjl5MRqLSo
         vGcgmVhAzx5FfXKSJ3r+X54u7lUl7ddH2BWVmhAec+3kyY9Mp0Kor3P1kwKpzWelMTyt
         AX83Z0jGYJun5EqWD49j2to8RWirMb4ZkG2l84nc8R4p7G/eBnOG6mU5zXSBHLQbgfvu
         ysKg==
X-Gm-Message-State: AElRT7Gorjeq66i55TWpW0ikWkHzBrCSqXVkUPMc1QXf6xFeCb+wDvG5
        rdGnUkN0ZK2omkPmGCQhYCE41sWNioo=
X-Google-Smtp-Source: AG47ELuXUg/xhOjw0U6csy6EzbG7sFEF7BbQWSWJYWMVMa8ha/8kExHzAo/CqC3iYp+GFXypXRcKZw==
X-Received: by 10.223.193.69 with SMTP id w5mr7910047wre.42.1521147940745;
        Thu, 15 Mar 2018 14:05:40 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u18sm6655395wrb.36.2018.03.15.14.05.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Mar 2018 14:05:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 5/5] ref-filter: get_ref_atom_value() error handling
References: <0102016225e61cc2-0d0c05ef-b999-4bf2-88ac-db9840dd2a87-000000@eu-west-1.amazonses.com>
        <20180315204709.1900787-1-martin.agren@gmail.com>
Date:   Thu, 15 Mar 2018 14:05:39 -0700
In-Reply-To: <20180315204709.1900787-1-martin.agren@gmail.com> ("Martin
        =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 15 Mar 2018 21:47:09 +0100")
Message-ID: <xmqqd1053v8c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

>>  static int grab_objectname(const char *name, const unsigned char *sha1,
>> -                          struct atom_value *v, struct used_atom *atom)
>> +                          struct atom_value *v, struct used_atom *atom,
>> +                          struct strbuf *err)
>>  {
>> ...
>> +               } else {
>> +                       strbuf_addstr(err, "BUG: unknown %(objectname) option");
>> +                       return -1;
>> +               }
>>         }
>>         return 0;
>>  }
>
> This is interesting. This die() is never ever supposed to actually
> trigger, except to allow a developer adding some new O_xxx-value to
> quickly notice that they have forgotten to add code here.

Yup, BUG() is meant for a case like this; the original code predates
the BUG("message") which in turn predates the die("BUG: message")
convention, I think.

>>         default:
>> -               die("Eh?  Object of type %d?", obj->type);
>> +               strbuf_addf(err, "Eh?  Object of type %d?", obj->type);
>> +               return -1;
>>         }
>> +       return 0;
>>  }
>
> This seems similar. The string here is quite sloppy, and I do not
> believe that the author intended this to be user-visible. I believe this
> is more like a very short way of saying "how could we possibly get
> here??". It could also be written as die("BUG: unknown object type %d",
> obj->type), or even better: BUG(...).

Likewise.
