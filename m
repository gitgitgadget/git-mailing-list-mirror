From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] option-strings: use OPT_PATH
Date: Mon, 23 Feb 2015 13:07:13 -0800
Message-ID: <xmqqd250s5fi.fsf@gitster.dls.corp.google.com>
References: <cover.1424707497.git.git@drmicha.warpmail.net>
	<9030a1bb1e7a03eedfd65432fabf385f457419d6.1424707497.git.git@drmicha.warpmail.net>
	<20150223182653.GB19904@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 23 22:07:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQ0Dr-0004lB-QO
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 22:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429AbbBWVHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 16:07:17 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751748AbbBWVHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 16:07:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B04A3969B;
	Mon, 23 Feb 2015 16:07:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fWur4oBinVG4E6H1MobWAPnjqnM=; b=ugdAO7
	0N5Q9njr3mxzVYvYutt+LzhgvUNC4xqxekNt3HX1uj24tiyjsem1/7UbDjf1s8/u
	fITeo1W8s2R+FkI6oRzjbJMdB2Oae4YzjGjrH8GPuPEa1DZQ37mNbJthwwIzx6AM
	+KzA4ImB13WEiKNT6RRkvHtygfN7R95Z+Z8Jo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RwaJ4zfNAvDQz9ufRK1hjQVQ1r635Jcy
	/RDJDnYsJplXv89vemAAXvvDDasEgE9+7pQpBOF8CjV0lE/Lqh3Z7jXAfGi0q755
	wTPpTdqVbcf8vXw27xHOJelnZAJLzRpWCh6K39XNo8FCh7hMU9RF8rOgvdXRJcmi
	9k/VDh1jfeA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 906AD3969A;
	Mon, 23 Feb 2015 16:07:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 10F2B39699;
	Mon, 23 Feb 2015 16:07:14 -0500 (EST)
In-Reply-To: <20150223182653.GB19904@peff.net> (Jeff King's message of "Mon,
	23 Feb 2015 13:26:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F151E28E-BB9F-11E4-82B3-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264299>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 23, 2015 at 05:17:45PM +0100, Michael J Gruber wrote:
>
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index a9af3f2..15941c5 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -80,7 +80,7 @@ static struct option builtin_clone_options[] = {
>>  		    N_("initialize submodules in the clone")),
>>  	OPT_BOOL(0, "recurse-submodules", &option_recursive,
>>  		    N_("initialize submodules in the clone")),
>> -	OPT_STRING(0, "template", &option_template, N_("template-directory"),
>> +	OPT_PATH(0, "template", &option_template, N_("template-directory"),
>>  		   N_("directory from which templates will be used")),
>>  	OPT_CALLBACK(0 , "reference", &option_reference, N_("repo"),
>>  		     N_("reference repository"), &opt_parse_reference),
>
> I'm not sure if this one is doing anything. Clone cannot use SETUP_GIT
> for obvious reasons, so we should have a NULL prefix here. But that also
> means we should be doing the right thing already.

I somehow thought that OPT_FILENAME already used expand_user_path()
but apparently it does not.  It may want to.

And then this change will start to matter, as a good enhancement.

Of course, if OPT_PATH() is introduced in such a way that the
program that uses the API can ask for "existing" and/or "directory",

    git clone --template=existing-file $URL
    git clone --template=no-such-directory $URL

can be diagnosed as an error without the program having to code very
much.

So, I agree that this change does not do anything in the current
codebase, but it goes in a right direction.
