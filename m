From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git grep -O -i: if the pager is 'less', pass
 the '-i' option
Date: Wed, 14 May 2014 11:26:54 -0700
Message-ID: <20140514182654.GA9218@google.com>
References: <20140514155010.GA4592@camelia.ucw.cz>
 <xmqq7g5okztp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stepan Kasal <kasal@ucw.cz>, GIT Mailing-list <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBD6LRKOE4AIRB4XKZ2NQKGQEUHH3HGQ@googlegroups.com Wed May 14 20:27:00 2014
Return-path: <msysgit+bncBD6LRKOE4AIRB4XKZ2NQKGQEUHH3HGQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f184.google.com ([209.85.214.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD6LRKOE4AIRB4XKZ2NQKGQEUHH3HGQ@googlegroups.com>)
	id 1WkdtL-0000ub-Ba
	for gcvm-msysgit@m.gmane.org; Wed, 14 May 2014 20:26:59 +0200
Received: by mail-ob0-f184.google.com with SMTP id vb8sf591702obc.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 14 May 2014 11:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=GXPIVHRNlWyHRaNHuShcBG4sQwnAM+FVGnLguR4H670=;
        b=ciPcaDARV6tn5HkORRVfZejkniu2LfD574AOOixi+BjsR5hcx3B1Rf7ZOKSeIkpOLm
         OuBe84rqf/5T9OV1yjWjwYJaQ+OfIzNP0aLrqF+N1H8y6e/7RgyAiGYfCC4iXtuqdUUR
         l0mZqOmTK+H33zMERLqBD3xwsTZjnCb+1Nv0sX1uOgI+qE45cx5jo875n5OMQyB38fE2
         PWfv0G7/MA4LWmZ5AP7TvxD9PALLDJSaspHhbBfFOjib41dqJqYQ11VDpI+MY3uY3L40
         yP8Z6s2WT6crESNW95COjqY2jNOsJ0ityAv3JRsNkyTVdTjZVBzfWV+uSmTD2OgZT89c
         7Gww==
X-Received: by 10.50.112.135 with SMTP id iq7mr174105igb.0.1400092018494;
        Wed, 14 May 2014 11:26:58 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.154.99 with SMTP id vn3ls2943350igb.39.gmail; Wed, 14 May
 2014 11:26:58 -0700 (PDT)
X-Received: by 10.50.73.132 with SMTP id l4mr18046427igv.5.1400092017996;
        Wed, 14 May 2014 11:26:57 -0700 (PDT)
Received: from mail-pb0-x231.google.com (mail-pb0-x231.google.com [2607:f8b0:400e:c01::231])
        by gmr-mx.google.com with ESMTPS id jx10si582694pbd.2.2014.05.14.11.26.57
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 14 May 2014 11:26:57 -0700 (PDT)
Received-SPF: pass (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:400e:c01::231 as permitted sender) client-ip=2607:f8b0:400e:c01::231;
Received: by mail-pb0-f49.google.com with SMTP id jt11so2000687pbb.36
        for <msysgit@googlegroups.com>; Wed, 14 May 2014 11:26:57 -0700 (PDT)
X-Received: by 10.68.194.134 with SMTP id hw6mr6319366pbc.49.1400092017872;
        Wed, 14 May 2014 11:26:57 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id is5sm4757775pbb.8.2014.05.14.11.26.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 May 2014 11:26:57 -0700 (PDT)
In-Reply-To: <xmqq7g5okztp.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Original-Sender: jrnieder@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:400e:c01::231
 as permitted sender) smtp.mail=jrnieder@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248932>

Hi,

Junio C Hamano wrote:
> Stepan Kasal <kasal@ucw.cz> writes:

>> --- a/builtin/grep.c
>> +++ b/builtin/grep.c
>> @@ -897,6 +897,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>>  		if (len > 4 && is_dir_sep(pager[len - 5]))
>>  			pager += len - 4;
>>  
>> +		if (opt.ignore_case && !strcmp("less", pager))
>> +			string_list_append(&path_list, "-i");
>
> I have a feeling that this goes against the recent trend of not
> mucking with the expectation of the users on their pagers, if I
> recall correctly the arguments for dropping S from the default given
> to an unconfigured LESS environment variable.

It's just missing an explanation.

When <command> happens to be the magic string "less", today

	git grep -O<command> -e<pattern>

helpfully passes +/<pattern> to less so you can navigate through
the results within a file using the n and shift+n keystrokes.

Alas, that doesn't do the right thing for a case-insensitive match.
For that case we should pass --IGNORE-CASE to "less" so that n and
shift+n can move between results ignoring case in the pattern.
(That's -I, not -i, because it ought to work even when the pattern
contains capital letters.)

"git grep" has other options that affect interpretation of the pattern
which this patch does not help with:

 * -v / --ignore-match: probably should disable this feature of -O.
 * -E / --extended-regexp
 * -P / --perl-regexp
 * -F / --fixed-strings: ideally would auto-escape regex specials.
 * -e<pattern1> --or -e<pattern2>

And git grep -Ovi has a similar bug, for which the fix is to add
\c to the pattern instead of passing an -I option.

But as is, it's an improvement, so (except that "-i" should be
replaced by "-I") it seems like a good change.

Hope that helps,
Jonathan

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
