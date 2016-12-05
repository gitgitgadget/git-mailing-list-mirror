Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A9A81FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 21:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751373AbcLEVOM (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 16:14:12 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:33649 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbcLEVOM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 16:14:12 -0500
Received: by mail-qt0-f174.google.com with SMTP id p16so326616695qta.0
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 13:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y+WNh63my90O7k5CNFyp5EI7uD5whQDFPepAgW+Crlg=;
        b=FdCGYmwO6PSyYegkuVZYMkOvRPXRRGpVLIx/tDNYYtB2P8gLUP/9h36F7/WVROSN3B
         1SKyxRXefZFRaI0Ed7V8PEn23ebk4oZsX2BDUU/Dcv8oRZeGL9NOXeEPbuUy2wwcJQbz
         ML2xn2ritYJ4HOGJxqI+ykZF9epcf9Z5rRcd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y+WNh63my90O7k5CNFyp5EI7uD5whQDFPepAgW+Crlg=;
        b=f9wcABKbS8vzfks/cgpKVXq3Hu3YWQMdMk6QqQ4QgM06JMPBLUTHRKSchh236x8j+X
         cyuwvuSYIzXxGgW+J7HPKVnU4cbFIaQvayFJXtET6I4jtNX96JRyJIqJKcd54NcbHaAP
         lWT7C2V9W40PIVsZNzvyv52CVEO3A6kyX1wBuxx3DNxHqzLbqn5yOB9tLNY4KRsl0D6j
         n078j5JJQFbxeJpPP6cu3ih9E9J7TnXHBoKDel2Wpt6l4GM/zmG3pYeg6k12bJwnm3Pl
         cEWNiI1w1MswD3PK8EUnUDZD+M0Wti5maH/6mm5sAXzMfefbB1RtlEwd8+5Krr38drbZ
         ocGw==
X-Gm-Message-State: AKaTC02005+IxhIA0UVnfTgwxAsqleocjSKLGBck+Cfb425kGsSQAFdcPrMg9cylvxxiwVkPaS1bTk0SO5JR6g==
X-Received: by 10.237.60.101 with SMTP id u34mr58652217qte.53.1480972403418;
 Mon, 05 Dec 2016 13:13:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.47.111 with HTTP; Mon, 5 Dec 2016 13:13:22 -0800 (PST)
In-Reply-To: <xmqq8tru3xom.fsf@gitster.mtv.corp.google.com>
References: <20161202224319.5385-1-luke@diamand.org> <20161202224319.5385-2-luke@diamand.org>
 <xmqq8tru3xom.fsf@gitster.mtv.corp.google.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Mon, 5 Dec 2016 21:13:22 +0000
Message-ID: <CAE5ih78Y_AbfgtW_6zMKLC8NzBxCKSagrgrjtfWZVOEwaAg6ZA@mail.gmail.com>
Subject: Re: [PATCHv1 1/2] git-p4: support git-workspaces
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Users <git@vger.kernel.org>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5 December 2016 at 20:53, Junio C Hamano <gitster@pobox.com> wrote:
> Luke Diamand <luke@diamand.org> writes:
>
>> Teach git-p4 about git-workspaces.
>
> Is this what we call "git worktree", or something else?

Ah, I think you're right!

>
>>
>> Signed-off-by: Luke Diamand <luke@diamand.org>
>> ---
>>  git-p4.py | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index 0c4f2afd2..5e2db1919 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -566,6 +566,12 @@ def isValidGitDir(path):
>>      if (os.path.exists(path + "/HEAD")
>>          and os.path.exists(path + "/refs") and os.path.exists(path + "/objects")):
>>          return True;
>> +
>> +    # git workspace directory?
>> +    if (os.path.exists(path + "/HEAD")
>> +        and os.path.exists(path + "/gitdir")):
>> +        return True
>> +
>>      return False
>>
>>  def parseRevision(ref):
