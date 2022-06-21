Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57613C433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 22:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiFUWQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiFUWQz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 18:16:55 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C472FFC6
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:16:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id eo8so21339799edb.0
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=MQ/8KduIybSMruNo5BNuGYYY8DeggDoW4V2ZDeSrWBg=;
        b=b7b5ASBV1/KmyQOkeYnrogzFYfWLCgnQYFVaqw/NTvWVGY55wcYknE6fMcAZXuJXU6
         W/JDqixAdO6Mfr7ym3/DMJlY2k3dSTzB7UTafOP9+YJNFNIa/UbFsKoETYJUf+fgPxUQ
         CtQmHssCFNsqVC2pdVO8HRGYWCjORDJh877U7DYHxr2tkTPvdLlGDrxJga73nD+XKoMo
         /6hPvwpba2FIIG9g1lxMbt6DLqtt6OKZVnh3NmXk2XeA7cLf+fLXJePxnwcdse1+JEdi
         IWakfRXPGe4zpr4EsTAfT5a508OHQgN1HaUJ/gwS6GDh5IjWjNebd06S+qPwU9lBKVoU
         35hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=MQ/8KduIybSMruNo5BNuGYYY8DeggDoW4V2ZDeSrWBg=;
        b=3vtT0VOAtUqZmXaE+xU+6TR7SqzDR9kkKaGlRW32gENyzXpFlawHXtTDhPT09dc/YQ
         jOKjV63CgDuzr6x4eFOY2edB8Dne/FklWVLD66v3mOlhBv69m5QsKtp36sP5EaDzYzOK
         JgyB0ZPmVtD6TAvy9cc0hyAOpTeUqxxoq1J17QzzqHY2lQr+lsdceDQQ4p8wqgMcd49e
         /R5our2dKNx1GkJdVC7KRG1hcay/1W2sGJb94gqt4zCJgrbKj1osdNE9Qh83TOgGLww9
         x6z68XW3y6ph9hy5aExNKtf4L2naVZvb6vATwLybSU8gOwx2xPjMOSGZsoRklx8bp0mq
         0WIA==
X-Gm-Message-State: AJIora8+uk4v40245YBgHAQBnu5A3INdpXq6Di/rhBunnd1KPGK9PiSu
        n97sEAjuysIZZXvqhEuAuO0=
X-Google-Smtp-Source: AGRyM1tDxJ5ZPAz8ne/gn3fhxr4nS+K9iW5E4KT2g/m+i21Y9FBpYIa5I4qwF3GC0qw8JenM/QEfWg==
X-Received: by 2002:a05:6402:750:b0:435:68bb:8552 with SMTP id p16-20020a056402075000b0043568bb8552mr335393edy.155.1655849812470;
        Tue, 21 Jun 2022 15:16:52 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id o2-20020a170906768200b0070fd7da3e47sm8201847ejm.127.2022.06.21.15.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 15:16:51 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o3mB0-000YCW-3H;
        Wed, 22 Jun 2022 00:16:50 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Stewart Smith <trawets@amazon.com>, git@vger.kernel.org,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] git-send-email: Add --no-validate-email option
Date:   Wed, 22 Jun 2022 00:12:24 +0200
References: <20220620004427.3586240-1-trawets@amazon.com>
 <YrEMq+slLOHqw/hz@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YrEMq+slLOHqw/hz@camp.crustytoothpaste.net>
Message-ID: <220622.864k0dmzl9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 21 2022, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2022-06-20 at 00:44:27, Stewart Smith wrote:
>> The perl Email::Valid module gets things right, but this may not always
>> be what you want, as can be seen in
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D2046203
>
> You should explain this in the body of the message, since we generally
> want to know the rationale behind the change even if RedHat moves away
> from Bugzilla in the future.
>
> You could say something like this:
>
>   The Perl Email::Valid module correctly checks whether an email address
>   is syntactically valid.  However, in some cases, people have email
>   addresses which are not syntactically valid, such as those where the
>   local-part is more than 64 octets, and would like to use those
>   addresses despite that fact.
>
>> So, add a --validate-email (default, current behavior) and
>> the inverse --no-validate-email option to be able to skip the check
>> while still having the Email::Valid perl module installed.
>>=20
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2046203
>
> I don't believe we generally include Fixes headers for external bugs.
>
>> Suggested-by: Todd Zullinger <tmz@pobox.com>
>> Signed-off-by: Stewart Smith <trawets@amazon.com>
>> ---
>>  git-send-email.perl   | 9 +++++++++
>>  t/t9902-completion.sh | 1 +
>>  2 files changed, 10 insertions(+)
>>=20
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index 5861e99a6e..c75b08f9ce 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -103,6 +103,7 @@ sub usage {
>>      --quiet                        * Output one line of info per email.
>>      --dry-run                      * Don't actually send the emails.
>>      --[no-]validate                * Perform patch sanity checks. Defau=
lt on.
>> +    --[no-]validate-email          * Perform email address sanity check=
s. Default on.
>>      --[no-]format-patch            * understand any non optional argume=
nts as
>>                                       `git format-patch` ones.
>>      --force                        * Send even if safety checks would p=
revent it.
>> @@ -281,6 +282,7 @@ sub do_edit {
>>  my $chain_reply_to =3D 0;
>>  my $use_xmailer =3D 1;
>>  my $validate =3D 1;
>> +my $validate_email =3D 1;
>>  my $target_xfer_encoding =3D 'auto';
>>  my $forbid_sendmail_variables =3D 1;
>>=20=20
>> @@ -293,6 +295,7 @@ sub do_edit {
>>      "tocover" =3D> \$cover_to,
>>      "signedoffcc" =3D> \$signed_off_by_cc,
>>      "validate" =3D> \$validate,
>> +    "validateemail" =3D> \$validate_email,
>>      "multiedit" =3D> \$multiedit,
>>      "annotate" =3D> \$annotate,
>>      "xmailer" =3D> \$use_xmailer,
>> @@ -531,6 +534,8 @@ sub config_regexp {
>>  		    "no-thread" =3D> sub {$thread =3D 0},
>>  		    "validate!" =3D> \$validate,
>>  		    "no-validate" =3D> sub {$validate =3D 0},
>> +		    "validate-email!" =3D> \$validate_email,
>> +		    "no-validate-email" =3D> sub {$validate_email =3D 0},
>>  		    "transfer-encoding=3Ds" =3D> \$target_xfer_encoding,
>>  		    "format-patch!" =3D> \$format_patch,
>>  		    "no-format-patch" =3D> sub {$format_patch =3D 0},
>> @@ -1132,6 +1137,10 @@ sub extract_valid_address {
>>  	# check for a local address:
>>  	return $address if ($address =3D~ /^($local_part_regexp)$/);
>>=20=20
>> +	# Email::Valid isn't always correct, so support a way to bypass
>> +	# See https://bugzilla.redhat.com/show_bug.cgi?id=3D2046203
>
> Email::Valid is in fact correct.  However, the email which you want to
> use doesn't conform to the RFC and isn't valid.  So this should probably
> say something like, "Allow people to use an email address which is not
> valid according to the RFCs if the server accepts it."

That's fair, but that rationale is quite disconnected from how the code
works now. You happen to get that check if you have Email::Valid
installed, otherwise not.

So if it's a use-case we care about we should make it a hard dependency.

> I think this patch would be fine as it stands with those changes. Unlike
> =C3=86var, I don't think we should get rid of Email::Valid, just like I d=
on't
> think we should get rid of the transfer encoding checks.  I support
> warning people before sending invalid emails, especially since I believe
> the address in question would not be deliverable through some mail
> servers (such as mine).

Would this be addressed by instead opening a connection to the server,
and seeing if it is willing to accept these addresess on a "RCPT TO"
line?

Which I think is what would happen anyway as you try to send the E-Mail,
I'm not sure what distinction you're drawing here (but I haven't looked
deeply into the control flow here).

I.e. if your MTA isn't going to accept an address that we regex match,
isn't it going to error when you try to send the mail, why isn't it
better and more reliable to offload more of that sort of validation to
the MTA?

As this report notes that can lead to cases where there's a mismatch
between the two, i.e. we can't format the E-Mail, but the MTA would be
happy to send it for us.
