X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: =?UTF-8?Q?Mihai_Capot=C4=83?= <mihai@mihaic.ro>
Subject: Re: [PATCH v2] count-objects: output "KiB" instead of "kilobytes"
Date: Thu, 4 Apr 2013 15:18:25 +0200
Message-ID: <CADyhzG3HJhrXJAoTfyHUsg=8ZmUUwUgrNfUiLHF0Ws=gSERAqw@mail.gmail.com>
References: <7vip44a8xl.fsf@alter.siamese.dyndns.org>
	<1364993331-20199-1-git-send-email-mihai@mihaic.ro>
	<7vd2ub7k7c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 4 Apr 2013 13:18:33 +0000 (UTC)
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=pXrR1U2/sLYj1qgdLi2Ka3XyDMbdDNhjoRr9+NerPvI=;
        b=SD+1ttmvmXG3kuJfl1EkrZMpBYFcj9z6dpt7GQWqyWelbLzsoq6U224Eqj9CKozmJp
         kbkUpLCMd1LiSF253EV980HI7maCASGcuIjRVLsdDEomY/CUGUVZB/VDqPxHMJMKXHmF
         RV02VhX0aUF8qYBCKBO7dFoCD2tttJFhCNpScxG1fQLPo031UShAu4jnuXlAyCfdRIyP
         UF87homr++mTL25oCJ/rnwuBmnPp3x04W/Lleyudb6HzI7Vnb50lF4HY4fX9RNSmo5l2
         CuJH4VjR9snbYxPDmGmK5DL/8Fu7v56nt9k7wWPUbYm9J+wMUz/b8EJXxsQyOCRq0h0C
         T8zQ==
X-Received: by 10.43.4.74 with SMTP id ob10mr3351914icb.28.1365081505430; Thu,
 04 Apr 2013 06:18:25 -0700 (PDT)
In-Reply-To: <7vd2ub7k7c.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQluPOWHNHwBEAM1tYS6/8vpMKGX0wvP2ZSCSeZXWPPu18wpg3lDKGfy6tdh8tyDtxpPWcZH
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220000>
Received: from vger.kernel.org ([209.132.180.67]) by plane.gmane.org with
 esmtp (Exim 4.69) (envelope-from <git-owner@vger.kernel.org>) id
 1UNk49-0005sN-7C for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 15:18:57
 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760428Ab3DDNS2 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Apr 2013 09:18:28 -0400
Received: from mail-ia0-f181.google.com ([209.85.210.181]:57993 "EHLO
 mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760423Ab3DDNS1 convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 4 Apr 2013 09:18:27 -0400
Received: by mail-ia0-f181.google.com with SMTP id o25so2183636iad.40 for
 <git@vger.kernel.org>; Thu, 04 Apr 2013 06:18:25 -0700 (PDT)
Received: by 10.64.7.75 with HTTP; Thu, 4 Apr 2013 06:18:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org

On Wed, Apr 3, 2013 at 4:38 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Mihai Capot=C4=83 <mihai@mihaic.ro> writes:
>> diff --git a/git-cvsimport.perl b/git-cvsimport.perl
>> index 73d367c..de44e33 100755
>> --- a/git-cvsimport.perl
>> +++ b/git-cvsimport.perl
>> @@ -1126,12 +1126,12 @@ unless ($opt_P) {
>>  }
>>
>>  # The heuristic of repacking every 1024 commits can leave a
>> -# lot of unpacked data.  If there is more than 1MB worth of
>> +# lot of unpacked data.  If there is more than 1MiB worth of
>>  # not-packed objects, repack once more.
>>  my $line =3D `git count-objects`;
>> -if ($line =3D~ /^(\d+) objects, (\d+) kilobytes$/) {
>> -  my ($n_objects, $kb) =3D ($1, $2);
>> -  1024 < $kb
>> +if ($line =3D~ /^(\d+) objects, (\d+) KiB$/) {
>> +  my ($n_objects, $kib) =3D ($1, $2);
>> +  1024 < $kib
>>      and system(qw(git repack -a -d));
>>  }
>
> This hunk makes me wonder if this s/kilobytes/kib/ is a good idea in
> the first place.  This in-tree user was lucky enough to have been
> caught and adjusted, but we don't know how many out-of-tree scripts
> are broken the same way and in need of a similar treatment.

The git manual contains an explicit warning about the output of a
porcelain command changing: "The interface to Porcelain commands on
the other hand are subject to change in order to improve the end user
experience."

