Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1800EC28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 11:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbiAZLjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 06:39:44 -0500
Received: from smtp36.i.mail.ru ([94.100.177.96]:60038 "EHLO smtp36.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233852AbiAZLjo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 06:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=IBEcwhCcIwQ6CpC3DHsxIotfC+1wLLqEqu1OoYaMyKI=;
        t=1643197183;x=1643802583; 
        b=TbnZYkK9e3HL+N5bH9Gz0De5PxQhGWMAmOMp3UCCrbCRtR9L+xrrgfeepgFGwm3nofghx/HUkjTWh14BW90KTsN4e/fzKuQoCBNi29ncxQzQjFzI1en3LLVyQiPhDpIl67INZFfAU/IraWhnwdXGaiV+MPhalqoy0jVF5IwWl1w=;
Received: by smtp36.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1nCgeL-00089l-Fk; Wed, 26 Jan 2022 14:39:42 +0300
Date:   Wed, 26 Jan 2022 14:39:39 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Konstantin Khomoutov <kostix@bswap.ru>, git@vger.kernel.org
Subject: Re: [RFC] shell: local x=$1 may need to quote the RHS
Message-ID: <20220126113939.cl5pbcous4gmdjri@carbon>
References: <xmqqsftc3nd6.fsf@gitster.g>
 <20220125092419.cgtfw32nk2niazfk@carbon>
 <xmqqa6fjzlm0.fsf@gitster.g>
 <YfBbRca0Rjl59MM0@nand.local>
 <xmqqo83zt54a.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo83zt54a.fsf@gitster.g>
Authentication-Results: smtp36.i.mail.ru; auth=pass smtp.auth=kostix@bswap.ru smtp.mailfrom=kostix@bswap.ru
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9AA78FDF62ECAE61F7A922168D8AD45D749A6A71140E6560E182A05F5380850402523AC05B12DA1761C4B0015D62BA5973386EC65677EF86F3D1641AF7F436515
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE77603ADE015AF816DEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637ED2BA022FBF94AB68638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D82717DF19759CDB76C39205D339F44A5A117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCF1175FABE1C0F9B6A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352033AC447995A7AD1828451B159A507268D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE652FD71AFB96DC7D148812EF9080FC94D8FC6C240DEA7642DBF02ECDB25306B2B78CF848AE20165D0A6AB1C7CE11FEE37812A6222701F2156136E347CC761E07C4224003CC836476EA7A3FFF5B025636E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F7900637AF8E4F18C523FAA9EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A540E8F1100AB2125ED36E2BE19B47E81C4824E6BB1378F2BFD59269BC5F550898D99A6476B3ADF6B47008B74DF8BB9EF7333BD3B22AA88B938A852937E12ACA75B742A0F936AD8A56410CA545F18667F91A7EA1CDA0B5A7A0
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D349A401E2B4D763A4A79606FDED788B15D38A6A913B9B336420444EA5DCD2A18FADC24CFD32AC825A11D7E09C32AA3244CB658C71956D6A9F7239271CF8E46477E259227199D06760A927AC6DF5659F194
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojF0Kx79yI7sUfPKivv/MVmg==
X-Mailru-Sender: 7E479B994E4F3A2CC35291DD34DB74CF04450A1BED1010BF7F34129C9AA2AB13D42F93969D0DF7B72F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 25, 2022 at 09:53:25PM -0800, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
>> Yeah; bisecting dash with your example script pointed me at cbb71a8
>> (eval: Add assignment built-in support again, 2018-05-19), which indeed
>> appears in v0.5.11 (and all subsequent versions).
>>
>> cbb71a8 points at release 0.3.8-15, which predates Git (and a tag
>> pointing at it was never created, since it's behind the big "initial
>> import" commit at the beginning of dash.git's history). But skimming
>> ChangeLog.O, we see:
>>
>>     * Removed assignment builtins since it is at best undefined by the
>>       SuS and also can't be implemented consistently.
>>
>> So this probably didn't work at all between that 0.3.8-15 up until v0.5.11.
[...]
> So here is a bit wider "grep" output, looking for
> 
> $ git grep '^[ 	]*local[	 ].*=' \*.sh
> 
> to reject _any_ assignment on the same line as "local", but I
> manually excluded the ones that are not meant to be run with dash.
> I obviously excluded the one in t0000 (try_local_xy) that is a
> weather-balloon for this exact issue.
> 
> According to this thread, these would not work correctly on dash
> older than 0.5.11 and needs fixing by splitting declaration of
> variables as locals and assignment of their initial values.

By the way, back then when Debian and Ubuntu were switching running their
system scripts from bash to dash (which bought definite speedups), many
scripts had to get rid of bashisms, and this page [1] summarizes quite many
differences between these shells including handing of `local`.
To cite it:

| Dash (old versions maybe?) and (at least) bash do not handle local the same:
|
| -    local a=5 b=6;
| +    local a=5;
| +    local b=6;
|
| The first line in /bin/bash makes a and b local variables. And in /bin/dash
| this line makes b a global variable! 

Not sure it lists a possible problems our test harness also has but wanted to
give a heads-up anyway just in case.

 1. https://wiki.ubuntu.com/DashAsBinSh

