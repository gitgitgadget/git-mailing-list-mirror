From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 04/11] ref-filter: add 'ifexists' atom
Date: Tue, 28 Jul 2015 23:09:10 +0530
Message-ID: <CAOLa=ZQ7Tc=73BFS_p5Dqnjn-SWhfJ6fqKyCOf71Mrj=puTjOg@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-4-git-send-email-Karthik.188@gmail.com>
 <vpq7fpk1x9a.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 28 19:40:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK8rG-0006H9-EK
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 19:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbbG1Rjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 13:39:43 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33683 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbbG1Rjn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 13:39:43 -0400
Received: by oixx19 with SMTP id x19so307228oix.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nIY8isciTPYkCJ3ePndG7G1XPsDPrK8gI+TKASGZfeM=;
        b=xxYnUkh6UlHVfoFoy+JbMjib9wlw9OHW17dcW9nlgU4rbgwfTKSxtz8Xdwm9h+5VLn
         ymjPhlNx3lGbOml4XgrpsweEdiC9aj6YlkChhhda9uF0YxRTmdDIjmoHLD9BfRxOfcxw
         vZ2BkTvT5U/fdA6xdKBTJnn11rNET00sq56zyX3MnBAnz6SLVDbf4NpwhFaosyLm5PTf
         HgTqpaAMNS9JsOrPpU+u9mAnYU/VC9usMneWIhRobZ94Pt1OJOOa5JsiftXppp86oWt1
         lxcTLGUpkx7AawmT/7sD4L+Z7e5VEDJwnTH5GiNP9mJo/AJHET6JhNb4u5+R325QJ5ij
         5a0Q==
X-Received: by 10.202.180.133 with SMTP id d127mr34031949oif.104.1438105180362;
 Tue, 28 Jul 2015 10:39:40 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Tue, 28 Jul 2015 10:39:10 -0700 (PDT)
In-Reply-To: <vpq7fpk1x9a.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274797>

On Tue, Jul 28, 2015 at 2:20 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> --- a/t/t6302-for-each-ref-filter.sh
>> +++ b/t/t6302-for-each-ref-filter.sh
>> @@ -149,4 +149,25 @@ test_expect_success 'check `colornext` format option' '
>>       test_cmp expect actual
>>  '
>>
>> +test_expect_success 'check `ifexists` format option' '
>> +     cat >expect <<-\EOF &&
>> +     [foo1.10]
>> +     [foo1.3]
>> +     [foo1.6]
>> +     EOF
>> +     git for-each-ref --format="%(ifexists:[%s])%(refname:short)" | grep "foo" >actual &&
>> +     test_cmp expect actual
>> +'
>
> You're testing only the positive case of ifexists, right? You need a
> test for the negative case (i.e. the attribute does not exist) too.
> Ideally, check that the ifexist actually applies to the right attribute,
> like
>
> --format '%(ifexist:<%s>)%(attribute1) %(ifexist:[%s])%(attribute2)'
>
> and manage to get an output like
>
> <foo>
>  [bar]
> <foobar> [barfoo]
>

Yes! this seems like an important test, thanks :)

>
> You have a double || that is not useful. Not really harmful either, but
> it may distract the reader. You may want to s/||/|/.
>

Will change!

-- 
Regards,
Karthik Nayak
