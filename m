From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [PATCH] rev-parse --parseopt: option argument name hints
Date: Sun, 09 Mar 2014 22:47:24 -0700
Message-ID: <531D51EC.6050503@gmail.com>
References: <1393842740-4628-1-git-send-email-ilya.bobyr@gmail.com> <xmqqwqg9kbuk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 06:47:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMt47-00060K-7N
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 06:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289AbaCJFrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 01:47:40 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:42159 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186AbaCJFrj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 01:47:39 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so6787381pbb.25
        for <git@vger.kernel.org>; Sun, 09 Mar 2014 22:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=41F+6NRl8yfpTeyjcS/Nkr4YIU510BOprpXfP3ci+OE=;
        b=u6sMsOEndBMEdE8w1Kdu8vd9CBlF5eibuBSJwPSj6Zo54X/Ewh3BEb91/qHj84b9Jg
         Sd6+Xb9BSPbhDt6kQ059t8FqtCVbPWGmyL3i5iRRrAxR9E1JF2HOHQqf6h1neJRYIzo4
         Elq4gIuLA8WlNgHtLiqp8TRlnPe93rkjLlu+MzxJwMFOc0tGtdGUyLeeioBTQ9Q5Y5qj
         JX/rS+0P81Iv/4WUUXiO/h5cjD/T1rhWTOR9qe3cJ4pMNuT94Z3yJLE+H/cwHxiBCIHK
         SSZ9QEKNpMCA/sgdRbMjQm0fA/TFtJq70HZ1UJurY3zqX2TqPxFBejO176Qhmah3nJbT
         PEXw==
X-Received: by 10.68.197.66 with SMTP id is2mr37873834pbc.96.1394430458521;
        Sun, 09 Mar 2014 22:47:38 -0700 (PDT)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id lh13sm73142864pab.4.2014.03.09.22.47.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Mar 2014 22:47:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:28.0) Gecko/20100101 Thunderbird/28.0
In-Reply-To: <xmqqwqg9kbuk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243705>

On 3/4/2014 11:22 AM, Junio C Hamano wrote:
> Ilya Bobyr <ilya.bobyr@gmail.com> writes:
>
>> Built-in commands can specify names for option arguments, that are shown
>> when usage text is generated for the command.  sh based commands should
>> be able to do the same.
>>
>> Option argument name hint is any text that comes after [*=?!] after the
>> argument name up to the first whitespace.  Underscores are replaced with
>> whitespace.  It is unlikely that an underscore would be useful in the
>> hint text.
>>
>> Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
>> ---
>>   Documentation/git-rev-parse.txt |   11 +++++++++--
>>   builtin/rev-parse.c             |   17 ++++++++++++++++-
>>   t/t1502-rev-parse-parseopt.sh   |   20 ++++++++++++++++++++
>>   3 files changed, 45 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
>> index 0d2cdcd..4cb6e02 100644
>> --- a/Documentation/git-rev-parse.txt
>> +++ b/Documentation/git-rev-parse.txt
>> @@ -284,13 +284,13 @@ Input Format
>>   
>>   'git rev-parse --parseopt' input format is fully text based. It has two parts,
>>   separated by a line that contains only `--`. The lines before the separator
>> -(should be more than one) are used for the usage.
>> +(could be more than one) are used for the usage.
> Good spotting.  I think the original author meant to say there
> should be at least one line to serve as the usage string, so
> updating it to "should be one or more" may be more accurate, but
> "could be more than one" would also work.

Changed to "should be one or more".

>>   The lines after the separator describe the options.
>>   
>>   Each line of options has this format:
>>   
>>   ------------
>> -<opt_spec><flags>* SP+ help LF
>> +<opt_spec><flags>*<argh>? SP+ help LF
>>   ------------
>>   
>>   `<opt_spec>`::
>> @@ -313,6 +313,12 @@ Each line of options has this format:
>>   
>>   	* Use `!` to not make the corresponding negated long option available.
>>   
>> +`<argh>`::
>> +	`<argh>`, if specified, is used as a name of the argument, if the
>> +	option takes an argument. `<argh>` is terminated by the first
>> +	whitespace. Angle braces are added automatically.  Underscore symbols
>> +	are replaced with spaces.
> I had a hard time understanding this "Angle brackets are added
> automatically" one (obviously nobody wants extra angle brackets
> added around option arguments given by the user), until I looked at
> the addition of the test to realize that this description is only
> about how it appears in the help output.  The description needs to
> be clarified to avoid confusion.

I've reworded some of the sentences.  I think it is better now.  Let me 
know what you think.

>> @@ -333,6 +339,7 @@ h,help    show the help
>>   
>>   foo       some nifty option --foo
>>   bar=      some cool option --bar with an argument
>> +baz=arg   another cool option --baz with an argument named <arg>
> It probably is better not to have " named <arg>" at the end here, as
> that gives an apparent-but-false contradiction with the "Angle
> brackets are added *automatically*" and confuse readers.  At least,
> it confused _this_ reader.

I am not sure I understand what is confusing here.  But I removed the " 
named <arg>" part.
If there would be an example, I think, it is easy to understand how it 
works.

> After the "eval" in the existing example to parse the "$@" argument
> list in this part of the documentation, it may be a good idea to say
> something like:
>
> 	The above command, when "$@" is "--help", produces the
> 	following help output:
>
> 	... sample output here ...
>
> to show the actual output.  That way, we can illustrate how input
> "baz?arg description of baz" is turned into "--baz[=<arg>]" output
> clearly (yes, I am suggesting to use '?' in the new example, not '='
> whose usage is already shown in the existing example).

Documentation on the whole argument parsing is quite short, so, I 
though, adding an example just to show how usage is generated would look 
like I am trying to make this feature look important than it is :)

I've added another section that shows usage text generated for the 
example specification.

>> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
>> index aaeb611..83a769e 100644
>> --- a/builtin/rev-parse.c
>> +++ b/builtin/rev-parse.c
>> @@ -395,9 +395,10 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
>>   		usage[unb++] = strbuf_detach(&sb, NULL);
>>   	}
>>   
>> -	/* parse: (<short>|<short>,<long>|<long>)[=?]? SP+ <help> */
>> +	/* parse: (<short>|<short>,<long>|<long>)[*=?!]*<arghint>? SP+ <help> */
>>   	while (strbuf_getline(&sb, stdin, '\n') != EOF) {
>>   		const char *s;
>> +		const char *argh;
> Let's spell that variable name out, e.g. arg_hint or something.

I was looking at the surrounding code for some style guidance, but most 
local variables have short names like "s", "o", "onb", "osz", "sb".
There are some that are longer.  So I was quite unsure here.
At the same time the target structure that holds the option description 
calls this string "argh".
Also, this is not really an "arg_hint" but the end of it.  Argument name 
is actually between s and argh, if there is some.
Considering all that, "argh" seemed like an OK name.

I've renamed it to "end".  It is used to remember possible end of the 
argument name in just one paragraph of code.
Comments above the paragraph clarifies what is been extracted.
Should there be another "parameter" in the option specification, the 
same variable could be used while parsing that one as well.

Let me know if you what that to be "arg_hint", or "arg_hint_end", or 
anything else.

>> diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
>> index 83b1300..bf0db05 100755
>> --- a/t/t1502-rev-parse-parseopt.sh
>> +++ b/t/t1502-rev-parse-parseopt.sh
>> @@ -18,6 +18,17 @@ An option group Header
>>       -C[...]               option C with an optional argument
>>       -d, --data[=...]      short and long option with an optional argument
>>   
>> +Argument hints
>> +    -b <arg>              short option required argument
>> +    --bar2 <arg>          long option required argument
>> +    -e, --fuz <with spaces>
>> +                          short and long option required argument
>> +    -s[<some>]            short option optional argument
>> +    --long[=<data>]       long option optional argument
>> +    -g, --fluf[=<path>]   short and long option optional argument
>> +    --longest <a very long argument hint>
>> +                          a very long argument hint
>> +
>>   Extras
>>       --extra1              line above used to cause a segfault but no longer does
>>   
>> @@ -39,6 +50,15 @@ b,baz     a short and long option
>>   C?        option C with an optional argument
>>   d,data?   short and long option with an optional argument
>>   
>> + Argument hints
>> +b=arg     short option required argument
>> +bar2=arg  long option required argument
>> +e,fuz=with_spaces  short and long option required argument
>> +s?some    short option optional argument
>> +long?data long option optional argument
>> +g,fluf?path     short and long option optional argument
>> +longest=a_very_long_argument_hint  a very long argument hint
>> +
> Nice.

Thanks :)

P.S. Patch comes in the next message.
