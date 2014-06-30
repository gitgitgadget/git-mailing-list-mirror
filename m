From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [RFC/PATCH] notes-util.c: replace git_config with git_config_get_string
Date: Mon, 30 Jun 2014 16:54:23 +0200
Message-ID: <53B17A1F.2030508@gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>	<1403520105-23250-4-git-send-email-tanayabh@gmail.com>	<CAPig+cRcbamkpeaoCMQ9yXtYeMEEL-ve--VWKg4MAWeS08Lqyg@mail.gmail.com>	<53ABD78E.3050800@gmail.com>	<CAPig+cSRBk5Q2amvFXyjH4dpoP83qbYUEUizE7v38Wh8Ofnfpw@mail.gmail.com>	<53B16748.8080703@gmail.com> <CAPig+cSpQ2NS9R-jsUvGFB0Uk5kqwhsFTm3RKhzcx+8FLyQgsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Tanay Abhra <tanayabh@gmail.com>, Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 16:54:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1cyX-0003ft-Ce
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 16:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548AbaF3Oy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 10:54:27 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:63591 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbaF3Oy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 10:54:26 -0400
Received: by mail-wi0-f178.google.com with SMTP id n15so6149762wiw.11
        for <git@vger.kernel.org>; Mon, 30 Jun 2014 07:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=LfX1JCsh/4AOvQO6p+DfpxV6XDyTw6ctI8bd86WzUc4=;
        b=VHYNz8A5JR5eZ6AXvk4cLcpXGOEDlnqHItgvVUzVRirgKOYagtWBYnBe+pJ9IHaNku
         slFm8euA0VYOC1UcIlWYJx2VEpTiI30dmVDxW16Oeu7bh9vZHV88TuPD5kESdq08mWOP
         t2kM+N6j8OreSVzK6wqKN23WEY+L4JduPcnbK/nNnvgiA+iwJHyvAVEtbPg3uMXe0KGp
         Gam51vNrg5mYtIT4BNIEXwzufcyOk3NUycR2l36++sAzkj/eefHT9BDqbaZyerV4T1I1
         vttCJ0E09/J1lG/ZC15SInDP9iRVXcW6gkOrzb75eSwBpenLECNX4dNXbmEzYBlhgKNr
         u2Og==
X-Received: by 10.194.10.167 with SMTP id j7mr4171503wjb.100.1404140064648;
        Mon, 30 Jun 2014 07:54:24 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id fs17sm3572060wjc.6.2014.06.30.07.54.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 30 Jun 2014 07:54:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CAPig+cSpQ2NS9R-jsUvGFB0Uk5kqwhsFTm3RKhzcx+8FLyQgsw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252673>

Am 30.06.2014 16:32, schrieb Eric Sunshine:
> On Mon, Jun 30, 2014 at 9:34 AM, Karsten Blees <karsten.blees@gmail.com> wrote:
>> Am 29.06.2014 13:01, schrieb Eric Sunshine:
>>> On Thu, Jun 26, 2014 at 4:19 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
>>>> On 6/25/2014 1:24 PM, Eric Sunshine wrote:
>>>>> On Mon, Jun 23, 2014 at 6:41 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
>>>>>> Use git_config_get_string instead of git_config to take advantage of
>>>>>> the config hash-table api which provides a cleaner control flow.
>>>>>>
>>>>>> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
>>>>>> ---
>>>>>>  notes-utils.c | 31 +++++++++++++++----------------
>>>>>>  1 file changed, 15 insertions(+), 16 deletions(-)
>>>>>>
>>>>>> diff --git a/notes-utils.c b/notes-utils.c
>>>>>> index a0b1d7b..fdc9912 100644
>>>>>> --- a/notes-utils.c
>>>>>> +++ b/notes-utils.c
>>>>>> @@ -68,22 +68,23 @@ static combine_notes_fn parse_combine_notes_fn(const char *v)
>>>>>>                 return NULL;
>>>>>>  }
>>>>>>
>>>>>> -static int notes_rewrite_config(const char *k, const char *v, void *cb)
>>>>>> +static void notes_rewrite_config(struct notes_rewrite_cfg *c)
>>>>>>  {
>>>>>> -       struct notes_rewrite_cfg *c = cb;
>>>>>> -       if (starts_with(k, "notes.rewrite.") && !strcmp(k+14, c->cmd)) {
>>>>>> -               c->enabled = git_config_bool(k, v);
>>>>>> -               return 0;
>>>>>> -       } else if (!c->mode_from_env && !strcmp(k, "notes.rewritemode")) {
>>>>>> +       struct strbuf key = STRBUF_INIT;
>>>>>> +       const char *v;
>>>>>> +       strbuf_addf(&key, "notes.rewrite.%s", c->cmd);
>>>>>> +
>>>>>> +       if (!git_config_get_string(key.buf, &v))
>>>>>> +               c->enabled = git_config_bool(key.buf, v);
>>>>>> +
>>>>>> +       if (!c->mode_from_env && !git_config_get_string("notes.rewritemode", &v)) {
>>>>>>                 if (!v)
>>>>>> -                       return config_error_nonbool(k);
>>>>>> +                       config_error_nonbool("notes.rewritemode");
>>>>>
>>>>> There's a behavior change here. In the original code, the callback
>>>>> function would return -1, which would cause the program to die() if
>>>>> the config.c:die_on_error flag was set. The new code merely emits an
>>>>> error.
>>>>
>>>> Is this change serious enough? Can I ignore it?
>>
>> IMO its better to Fail Fast than continue with some invalid config (which
>> may lead to more severe errors such as data corruption / data loss).
>>
>>>
>>> I don't know. Even within this single function there is no consistency
>>> about whether such problems should die() or just emit a message and
>>> continue. For instance:
>>>
>>> - if "notes.rewritemode" is bool, it die()s.
>>>
>>> - if "notes.rewritemode" doesn't specify a recognized mode, it
>>> error()s but continues
>>>
>>
>> I think this would also die in git_parse_source():
>> ...
>>     if (get_value(fn, data, var) < 0)
>>       break;
>>   }
>>   if (cf->die_on_error)
>>     die("bad config file line %d in %s", cf->linenr, cf->name);
>> ...
> 
> One would expect so, but notes-utils.c:notes_rewrite_config() is
> actually doing this:
> 
>     if (!c->combine) {
>         error(_("Bad notes.rewriteMode value: '%s'"), v);
>         return 1;
>     }
> 
> Rather than returning the -1 result of error(), which would make
> git_parse_source() die(), it's explicitly returning 1, which
> get_parse_source() ignores.
> 

Ahh...I missed the '< 0', sorry.
