From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH 00/11] completion: general cleanups
Date: Sat, 27 Apr 2013 22:13:15 +0200
Message-ID: <517C315B.2080106@gmail.com>
References: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>	<517BB798.4070703@gmail.com>	<CAMP44s1od7W0OufMhn2TCZTAo0aK9D+7VLzwVy7BSGNxAMuk6w@mail.gmail.com>	<CAMP44s3h43S=A7+QEWuv0iefxbXyKZsiJ2QMdc-XiouoO3yYng@mail.gmail.com>	<517BF167.7090300@gmail.com> <CAMP44s32WrnFr9Lp03Wu8gC6=FaACBtDbi1rnu=bo94Aa73TBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 22:13:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWBUq-0001n1-Fh
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 22:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290Ab3D0UNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 16:13:20 -0400
Received: from mail-ee0-f42.google.com ([74.125.83.42]:46621 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141Ab3D0UNT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 16:13:19 -0400
Received: by mail-ee0-f42.google.com with SMTP id c41so1875896eek.29
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 13:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=gJIHcr0qtE2C+Jbk0O2Hks74GC3mKlmXWdQ+MVYlxNg=;
        b=GOpG1RSCtx8GBHXGa5e1d71WHEsNcM/biYJSbP3hC544ufGZ+mLj4WAVC6YC9Xvf9L
         0EYUTsR0pYgepUWCQDjU4VNk1Bx2tjS4ItgP2u1pCt7+3gzeGH+5SE4ureRDfVb1Sgh+
         tIU60aSInY+ZBP0WSUvdWjpUgB4dsyNY00NPvw7/Ea5YZBKNCRd4a6w7eTDcoAH6FrMm
         s6NgF6nGNFa9I25V6aFL0JcEp344W7AvdXZIn3aV2VdaS6caY/1/UgyOs38s7YuaLKu7
         GMolbeeHcn7Gmwb9n34DtKN+LVlfejdNo6sfwGxprH5T5SqCirPQNRS8vlgToA1Lct1E
         PDPA==
X-Received: by 10.14.87.199 with SMTP id y47mr103897559eee.17.1367093598569;
        Sat, 27 Apr 2013 13:13:18 -0700 (PDT)
Received: from [192.168.0.3] ([151.70.212.83])
        by mx.google.com with ESMTPSA id cd3sm23691126eeb.6.2013.04.27.13.13.16
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 13:13:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <CAMP44s32WrnFr9Lp03Wu8gC6=FaACBtDbi1rnu=bo94Aa73TBA@mail.gmail.com>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222692>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 27/04/2013 21:15, Felipe Contreras ha scritto:
> [...]
>>> @@ -480,7 +481,7 @@ __git_complete_revlist_file ()
>>>  # The exception is --committable, which finds the files appropriate commit.
>>>  __git_complete_index_file ()
>>>  {
>>> -       local pfx="" cur_="$cur"
>>> +       local pfx="" cur_="$cur" old
>>>
>>>         case "$cur_" in
>>>         ?*/*)
>>> @@ -490,7 +491,8 @@ __git_complete_index_file ()
>>>                 ;;
>>>         esac
>>>
>>> -       __gitcomp_nl "$(__git_index_files "$1" "$pfx")" "$pfx" "$cur_" ""
>>> +       compopt -o filenames +o nospace 2> /dev/null || old=1
>>> +       __gitcomp_nl "$(__git_index_files "$1" "$pfx" "$old")" "$pfx" "$cur_" ""
>>>  }
>>>
>>>  __git_complete_file ()
>>>
>>
>> I like the idea (but I have not tested it), however compopt is called
>> two times, for each completion.
> 
> Why two times?

Ah, right; sorry.
I missed the fact that you are using __gitcomp_nl instead of my
__gitcomp_file.

> 
>> Maybe we can test for `-o filenames` support when script is loaded,
>> where currently there is a Bash version check, and set a global variable?
> 
> Yeah, that's the way bash-completion used to do it. But I wonder if we
> should be worrying about this at this point, even bash-completion
> dropped support for bash < 4 more than two years ago, and even debian
> stable is at 4.1.
> 

I'm +0.

> [...]


Regards  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlF8MVsACgkQscQJ24LbaUSY/wCgkq8CQeVGNpZFtchiLAKXYpxS
wsAAnR0abrQzA1jW+Do7CSuJOZVMRuJu
=zPgk
-----END PGP SIGNATURE-----
