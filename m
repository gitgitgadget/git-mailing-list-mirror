From: Hong Xu <xuhdev@gmail.com>
Subject: Re: [BUG] git bash-completion is incorrect for "git pull origin mas<tab>"
 if the ssh key is encrypted
Date: Thu, 22 Mar 2012 21:00:52 +0800
Message-ID: <4F6B2284.5030508@gmail.com>
References: <4F6AC0FA.7040708@gmail.com> <4F6AFEC8.9090907@in.waw.pl> <4F6B16BE.1050003@viscovery.net> <03324BD2-116A-42EF-AB18-38F4A30A1115@gmail.com> <4F6B2146.8060408@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Mar 22 14:01:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAheH-0001ja-QT
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 14:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757893Ab2CVNBp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Mar 2012 09:01:45 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64438 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453Ab2CVNBo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 09:01:44 -0400
Received: by ghrr11 with SMTP id r11so1684573ghr.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 06:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=oqjIPpMKFP0Z5Bk50CsK4DtHPUuyGpIsiC8rEdf1zkk=;
        b=QFimz4inydYuEXrwz7NhmpfoSvH25U4z5EKjY7tcjPo92pbVVlCvMN6tgiXMfZiUxC
         zZ6EHs//QPU07WkdzQbETgcNYybp8E0yPO5vkrOjVI1Omt5GO4TfCba54d8vNnU3bRWX
         hqSnGIR1SeeFbdoohm19obm0/RnVn+YRh8e5sNqjDxUreFhJDBczMNTVQ/KWxHQrEeBv
         MtbZUNrhKIqIHK7Oweh4t0dovq1GFSAQDn4DhGS8oRuuDnp6A7qv5sJS6W8XCxgABYmP
         rzYSJhg4AY/5MSoH5AxO/02/OhaU5QUoRAdwABG05VVasLadhd+Gdo0HtnW4e55xuCpk
         TxIA==
Received: by 10.60.14.136 with SMTP id p8mr9282560oec.68.1332421299859;
        Thu, 22 Mar 2012 06:01:39 -0700 (PDT)
Received: from [202.38.85.242] ([202.38.85.242])
        by mx.google.com with ESMTPS id b2sm4617638obo.22.2012.03.22.06.01.36
        (version=SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 06:01:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120312 Thunderbird/11.0
In-Reply-To: <4F6B2146.8060408@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193653>

On 03/22/2012 08:55 PM, Zbigniew J=C4=99drzejewski-Szmek wrote:
> On 03/22/2012 01:48 PM, Hong Xu wrote:
>>
>>
>> On Mar 22, 2012, at 20:10, Johannes Sixt<j.sixt@viscovery.net> wrote=
:
>>
>>> Am 3/22/2012 11:28, schrieb Zbigniew J=C4=99drzejewski-Szmek:
>>>> On 03/22/2012 07:04 AM, Hong Xu wrote:
>>>>> Hello everyone,
>>>>>
>>>>> If my ssh key is encrypted, "git pull origin mas<tab>" will give =
a
>>>>> unexpected result, something like this:
>>>>>
>>>>> git pull origin masEnter passphrase for key '/home/user/.ssh/id_r=
sa':
>>>>>
>>>>> I know maybe it is not possible to complete the "master", but may=
be it
>>>>> is better to not complete anything than append something like tha=
t?
>>>> It is ssh itself which emits this message. The completion script c=
alls
>>>> 'git ls-remote origin', which in turn invokes ssh. Typing the
>>>> password in
>>>> actually works, but I understand that you are annoyed by the messa=
ge.
>>>>
>>>> I don't think there's an easy way to silence this in git completio=
n,
>>>> without affecting other times when the key would be requested. E.g=
=2E we
>>>> would want ssh to ask for the key while doing 'git pull', but not
>>>> when run
>>>> automatically during completion.
>>>>
>>>> Maybe git-ls-remote should learn --quiet?
>>>
>>> No. IMHO, bash completion stretches too far by asking the remote fo=
r the
>>> refs that it has.
>>>
>>
>> I agree with this rather than using silent mode. If a encrypted key =
is
>> found, I think we better drop the completion. I don't know whether
>> there is a way to implement this yet, at least we can try to find it=
=2E
> There's more than one reason why ssh would ask for a password. So jus=
t
> checking for an encrypted key is pointless. Instead, ssh could be
> invoked with -o BatchMode=3Dyes. ls-remote could pass this option if =
it
> was invoked with --quiet.

This is a good idea.

>
> Possible this is just not worth the trouble and Hong should enter the
> run ssh-agent and enter the password beforehand.

If I entered the password, it would be like this:

git pull origin masEnter passphrase for key '/home/user/.ssh/id_rsa':
ter

Then I press Enter, the command runs as it should be. The only problem=20
is that this is a bit annoying.

Hong
