Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CDF3211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 00:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeLFA4z (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 19:56:55 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61590 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeLFA4z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 19:56:55 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A1D42CB49;
        Wed,  5 Dec 2018 19:56:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UNNHbztcYgXU
        C3UT7IIKstNIDuk=; b=tSQOl1JzTfRc0fjywtYOHUzjnAHk0RYKCgF6P1NJjjGv
        TPZOk2DOglPEGnKrieEnJ5jqRHloWkcpkWNOsyvkEEIIb5ZU/P6tc3Zh7AdGjNP6
        P5asslqO08vsp9KlYHvEtk38aJDTZejki9APdMhyDP8coGiNMABulp8pYvu7CIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=A+ezTl
        jfhqa7zTXSO4GBaJOATNAq2eBNMhDXYdjxbC+DB2zdYom06rc8B24jn0XP110XAK
        XceHnWAgJ3UhPzEc0g2OEzuintfdwGDTpl0nLATkPHxxLbWq5IQdFVPCVcd6ecL5
        DYSUNHafrzSGXg1rSdXDkngAZYcaW0bvj1OMg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 923C62CB48;
        Wed,  5 Dec 2018 19:56:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AD05C2CB47;
        Wed,  5 Dec 2018 19:56:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Martin Mares <mj@ucw.cz>,
        git@vger.kernel.org
Subject: Re: gitweb: local configuration not found
References: <154401401074.29584.11169979442731329694.reportbug@gimli.ms.mff.cuni.cz>
        <20181205184404.GC246451@google.com>
        <87bm5zzt4a.fsf@evledraar.gmail.com>
Date:   Thu, 06 Dec 2018 09:56:48 +0900
In-Reply-To: <87bm5zzt4a.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 05 Dec 2018 20:11:17 +0100")
Message-ID: <xmqq5zw7bhgv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D0B69108-F8F1-11E8-8B56-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Documentation says "If you are absolutely certain that you want your
>> script to load and execute a file from the current directory, then use
>> a ./ prefix".  We can do that, like so:
>>
>> diff --git i/gitweb/Makefile w/gitweb/Makefile
>> index cd194d057f..3160b6cc5d 100644
>> --- i/gitweb/Makefile
>> +++ w/gitweb/Makefile
>> @@ -18,7 +18,7 @@ RM ?=3D rm -f
>>  INSTALL ?=3D install
>>
>>  # default configuration for gitweb
>> -GITWEB_CONFIG =3D gitweb_config.perl
>> +GITWEB_CONFIG =3D ./gitweb_config.perl
>>  GITWEB_CONFIG_SYSTEM =3D /etc/gitweb.conf
>>  GITWEB_CONFIG_COMMON =3D /etc/gitweb-common.conf
>>  GITWEB_HOME_LINK_STR =3D projects
>>
>> but that does not help if someone overrides GITWEB_CONFIG, and besides=
,
>> it would be nicer to avoid the possibility of an @INC search altogethe=
r.
>> ...
> Just:
>
>     local @INC =3D '.';
>     do 'FILE.pl';
>
> Would do the same thing, but seems like a more indirect way to do it if
> all we want is ./ anyway.

Yeah, it does look indirect.  Despite what you said, it also would
support users giving an absolute path via GITWEB_CONFIG.

With "use File::Spec", perhaps something like this?

 gitweb/gitweb.perl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2594a4badb..239e7cbc25 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -719,6 +719,10 @@ sub filter_and_validate_refs {
 sub read_config_file {
 	my $filename =3D shift;
 	return unless defined $filename;
+
+	$filename =3D File::Spec->catfile(".", $filename)
+		unless File::Spec->file_name_is_absolute($filename);
+
 	# die if there are errors parsing config file
 	if (-e $filename) {
 		do $filename;
