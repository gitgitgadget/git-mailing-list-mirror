Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35C681F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 16:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfKNQBf (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 11:01:35 -0500
Received: from mout.web.de ([212.227.17.11]:44891 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfKNQBe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 11:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573747287;
        bh=9TzO1FTqnTaN4rFiXE5oXr/WQykjNcF9aYKknzMps5k=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FGXQ+j6lWjKdA/odMvWUJom22LWJEIWPuO+fzV0WPQKoltIAMLK9l69xbZuFvz5QV
         beH877938+hfAOgc0pAQNKze9+zCdZqIL2MA+JNN56Ot6+W1PcQBQg0e2GCne4A2S3
         0reNzxYNyp7u75N7SCzf7WOPOXCo3z/P0YKY7gwY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lal6K-1i2mNT27lw-00kRUB; Thu, 14
 Nov 2019 17:01:27 +0100
Subject: Re: [PATCH] parse-options: use COPY_ARRAY in parse_options_concat()
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <df941c25-22ea-3523-9607-8e892dea320c@web.de>
 <20191113182548.1707-1-martin.agren@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <686d3b30-9f1e-a871-7dab-e35f1d6d1499@web.de>
Date:   Thu, 14 Nov 2019 17:01:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113182548.1707-1-martin.agren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WH4Tp1fFCzVwyidaxIx1oCX7zpXknMXh/hDJL4X1Ch2ncKpUXYi
 XAaRPwQ7nXSDZI9fFdgWj/GAWWM/PkFRi9a4YY/BCjqNUJvDf9T9wi9CHNhfNn00ocHmFju
 PCz+kZp8cGKMge91AUA+R5T0ccFRXeAdBDnBjbnXPbfIEcgY4R6kgRoIu+aWBTFO8Rov0I4
 tqBBxSQNYctK9Kk0HIDAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z6CewrOXhQE=:YycFWd6Cw/AXSVflW/SR+6
 hq9rtP0g+slsVgC48qykXo4wbcb8wJlBfweqSqS/fSfAkayyhXqparmkLiR2VRF0+o/4/4TAV
 73bbVSjNCXNSCM2wl/0T6QWjYWO3LMyIv8qdqnFCRspzxL0zxBR13psF+WMxxZnl5i3Yeo4Ty
 RvHF+64MhoJU+yKf7zctE+Mapy7IiCJ8QgHXre1YQgQZbs7GF3l768MR58jqEEblhPr/ZjBAg
 3tMDxua8L8NZcbgAHr6d9f+i8kEL82AxZvlC2a0sPMiAcJUPzHqQ79BTpsGJQhFsSu/ghUczi
 gWpEG2kjYZ75lXPLU4yAR5cDL+XelpKmKsBHukgu/hgjIKNEzIXZhGQ3IpI//uR/Kdbbh111h
 xkxRY60SSGJa8xZqytA+EU+OjzioaS3AS4IoSptgX/RypsUVx5BHUc4rUB29KlTkjVwzVTBxF
 +bOMt9Q2nVE3ltbCLlGe2JSvP23YOBgMA/tEu4r1sfTqBV5bzLdoWI+NvkwP8RSa50rCspSZn
 QQUQJyYQO7jLCvw5GikOG1PF5DhCHHRvPXl24hLrdqngt2d57V4J90YuOk5Y9R87CfMWyLeLo
 DAlYMUZEi+vZecWifuMz2HHZa9qHfZVtwgsjGKR2/JaiTaY9aWwDKijpi8KTLQfhbVX2oV/UJ
 BuML2y7fGNcJQslUBqXPlnZJLE85FYT91FsDNxp9HZ6u9VQAIXXz2gzEZ5rPwo22VCB3/AMyi
 uffF0AAZDqI3+ypqhy18vGMHFBnvfAp3fCU0iDIj55y++7LHREMDHyZrQJXRC61aLRHoM3UCq
 aljd0qmiI5mZsN6eGc+GQDjUNgfVYVCoIHlnbEh8bpT1dBwBPcBB5XZBje6LMgcOHQNE1ifdQ
 nQssthhDqXyZJ2N0VMKg638FWdTeUQPoLjolfcIyvVMJeLdSmzMWEBzViKPjf4z5u5I6ic5fH
 YtjB6Tyidlc9RbC7CCuMq/b+hUtVLy6IUVFo8cxzH9bVLxaO0fQtoVR1Pv8uVB7QKp3hPvauJ
 PQZgDKp23x+PaaWuu3e1tlGilITaGYfczGndEJZcSgRBbAcBEvVZMVJ1ekAPbBsvfO9SZPE9a
 ImeEsu0eppUBy8EDdXlcY+VX9QoMLghdR+oxv9wPGLTC/WNGPErlxF5Mrb/cML6IpT24gaTQ+
 8fTCLFjVU+zUVehi9zgKHk6IwMjCVgbd/kzqmXALNAy1umj8hsxB85L6omatD/QgiSHaE0krC
 w9utBA1sSJb0twx1b/IKRqxT+n/bYUZUGH1gr3g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.11.19 um 19:25 schrieb Martin =C3=85gren:
> On Wed, 13 Nov 2019 at 18:19, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>         ALLOC_ARRAY(ret, st_add3(a_len, b_len, 1));
>> -       for (i =3D 0; i < a_len; i++)
>> -               ret[i] =3D a[i];
>> -       for (i =3D 0; i < b_len; i++)
>> -               ret[a_len + i] =3D b[i];
>> +       COPY_ARRAY(ret, a, a_len);
>> +       COPY_ARRAY(ret + a_len, b, b_len);
>>         ret[a_len + b_len] =3D b[b_len]; /* final OPTION_END */
>
> Maybe include that last one in the COPY_ARRAY with something like this
> on top?
>
> -       COPY_ARRAY(ret + a_len, b, b_len);
> -       ret[a_len + b_len] =3D b[b_len]; /* final OPTION_END */
> +       /* 1 more to include the final OPTION_END */
> +       COPY_ARRAY(ret + a_len, b, st_add(b_len, 1));

I'd rather move towards allowing a and b to be NULL, for consistency and
safety.  Will send patches eventually, but preferably only once the
original patch hits master.  These follow-ups that I have in mind aren't
terribly urgent.

Ren=C3=A9
