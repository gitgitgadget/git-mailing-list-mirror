From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 8/8] reflog_expire(): lock symbolic refs themselves, not
 their referent
Date: Sat, 14 Feb 2015 06:58:05 +0100
Message-ID: <54DEE3ED.4020408@alum.mit.edu>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>	<1423473164-6011-9-git-send-email-mhagger@alum.mit.edu>	<CAGZ79kaBGAOt-R1=mSG5H-5p=2UWjZEesktVwQcDAWFC-OW2Eg@mail.gmail.com>	<xmqq61b8t65x.fsf@gitster.dls.corp.google.com>	<CAGZ79kaaQWRXhph=0g3SRHKXMoW8eAp7QG21yuWXWd7OW4M+uA@mail.gmail.com>	<54DCDA42.2060800@alum.mit.edu>	<CAGZ79kZgjRNS3zd4Tif6M66mjkP6-tDpy4FAtio8jiwqHxUtgw@mail.gmail.com>	<54DE259C.4030001@alum.mit.edu>	<xmqqoaoxoffe.fsf@gitster.dls.corp.google.com>	<CAGZ79kZpCjcGeifbLztpNUSq7-3Yy2_GEVPGEQsxrgoZfLFU+g@mail.gmail.com>	<xmqqk2zloeg1.fsf@gitster.dls.corp.google.com>	<CAGZ79kYRi3KYcvNQbkhP0uLFgpJzD+h=P+smOLQy2Msv0C_1kw@mail.gmail.com>	<xmqqa90hocc5.fsf@gitster.dls.corp.google.com>	<54DE5A72.6030106@alum.mit.edu> <xmqq3869mqbf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?Yw==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>,
	=?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 06:58:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMVkK-0006Fb-Rn
	for gcvg-git-2@plane.gmane.org; Sat, 14 Feb 2015 06:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbbBNF6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2015 00:58:20 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:47094 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751125AbbBNF6T (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Feb 2015 00:58:19 -0500
X-AuditID: 1207440e-f79bc6d000000c43-09-54dee3f1defe
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 0E.7F.03139.1F3EED45; Sat, 14 Feb 2015 00:58:09 -0500 (EST)
Received: from [192.168.69.130] (p5DDB3718.dip0.t-ipconnect.de [93.219.55.24])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1E5w6aj022605
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 14 Feb 2015 00:58:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <xmqq3869mqbf.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsUixO6iqPvx8b0Qg0v3lCymd61msei60s1k
	0dB7hdni7c0ljBbdU94yWvT2fWK12Ly5ncWB3ePSupdMHjtn3WX3WLCp1OPiJWWPz5vkAlij
	uG2SEkvKgjPT8/TtErgzNpxoZyl4Il7xbf87xgbGo0JdjJwcEgImEpsefWeCsMUkLtxbz9bF
	yMUhJHCZUaKh7xk7hHOOSWLnu7ksXYwcHLwC2hL/FyaAmCwCqhIXzqqC9LIJ6Eos6mkGmyMq
	ECRx6PRjFhCbV0BQ4uTMJ2C2iICaxMS2QywgI5kF7jBJrNvwH6xBWCBW4uedh6wQu+azSbxY
	MR0swSlgLXH1+lp2kGXMAuoS6+eBHc0sIC/RvHU28wRGgVlIdsxCqJqFpGoBI/MqRrnEnNJc
	3dzEzJzi1GTd4uTEvLzUIl1jvdzMEr3UlNJNjJCQ59vB2L5e5hCjAAejEg+vxNJ7IUKsiWXF
	lbmHGCU5mJREeT+vAQrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4fW5DZTjTUmsrEotyodJSXOw
	KInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnwTn4E1ChYlJqeWpGWmVOCkGbi4AQZziUlUpya
	l5JalFhakhEPitP4YmCkgqR4gPbGgbTzFhck5gJFIVpPMSpKifNOBEkIgCQySvPgxsIS2StG
	caAvhXn3gVTxAJMgXPcroMFMQIMnzrgNMrgkESEl1cAocTye65ycD4up66RPJpyzDG/cqn4V
	f1fknd3k/JV1dkGZ8UlF0b92LphXXp6xuHFyf7jFyUs56ic2pcpy9O1K2/Njy0ae 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263847>

On 02/13/2015 10:53 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Now back to the real world. Currently, if R is changed *through* a
>> symbolic reference S, then the reflogs for both R and S are updated, but
>> not the reflogs for any other symbolic references that might point at R.
>> If R is changed directly, then no symref's reflogs are affected, except
>> for the special case that HEAD's reflog is changed if it points directly
>> at R. This limitation is a hack to avoid having to walk symrefs
>> backwards to find any symrefs that might be pointing at R.
> 
> Yup.
> 
>> It might actually not be extremely expensive to follow symrefs
>> backwards. Symbolic references cannot be packed, so we would only have
>> to scan the loose references; we could ignore packed refs. But it would
>> still be a lot more expensive than just updating one file. I don't know
>> that it's worth it, given that symbolic references are used so sparingly.
> 
> I personally do not think it is worth it.  I further think that it
> would be perfectly OK to do one of the following:
> 
>     - We only maintain reflogs for $GIT_DIR/HEAD; no other symrefs
>       get their own reflog, and we only check $GIT_DIR/HEAD when
>       updating refs/heads/* and no other refs for direct reference
>       (i.e. HEAD -> refs/something/else -> refs/heads/master symref
>       chain is ignored).
> 
>     - In addition to the above, we also maintain reflogs for
>       $GIT_DIR/refs/remotes/*/HEAD but support only when they
>       directly point into a remote tracking branch in the same
>       hierarchy.  $GIT_DIR/refs/remotes/foo/HEAD that points at
>       $GIT_DIR/refs/remotes/bar/master is ignored and will get an
>       undefined behaviour.

Yes. The first is approximately the status quo, except that you would
like explicitly to *suppress* creating reflogs for symbolic refs other
than HEAD even if a reference is altered via the symbolic ref.

The second makes sense, though I think reflogs for remote HEADs are far
less useful than those for HEAD. So I think this is a low-priority project.

>> I think that the rule about locks as expressed above can be carried over
>> the the real world:
>>
>>     We should hold the locks on exactly those references (symbolic
>>     or regular) whose reflogs we plan to change. We should acquire all
>>     of the locks before making any changes.
> 
> Sure.

I forgot to mention that if we want to retain lock-compatibility with
older clients, then we *also* need to lock the reference pointed at by a
symbolic ref when modifying the symbolic ref's reflog. This is often
implied by the previous rule, but not when we reseat a symbolic
reference or when we expire a symbolic reference's reflog.

I will look at how hard this is to implement. If it is at all involved,
then I might drop this patch from the current patch series and defer it
to another one.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
