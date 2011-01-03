From: Maaartin-1 <grajcar1@seznam.cz>
Subject: Re: Commiting automatically (2)
Date: Mon, 03 Jan 2011 01:39:00 +0100
Message-ID: <4D211AA4.4050108@seznam.cz>
References: <loom.20101219T090500-396@post.gmane.org> <m34oa7l1hq.fsf@localhost.localdomain> <4D1190A6.4070201@seznam.cz> <201012271304.03915.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 03 01:39:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZYSB-00055c-Jx
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 01:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046Ab1ACAjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 19:39:08 -0500
Received: from smtp.seznam.cz ([77.75.72.43]:44228 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995Ab1ACAjG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 19:39:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=beta; d=seznam.cz;
	h=X-Seznam-DomainKeys:X-Seznam-SPF:X-Virus-Info:Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Smtpd:X-Seznam-User:X-Session:X-Country:X-QM-Mark;
	b=AZfGLlXAcloTzggyE/6g+jyx1+Bo4HhWrlXa1jktmszyvo5BrYND23eeNUoUmm893
	ES+Hq6a3Z8uYge/B0R2k1Yr8SsMTCrwVkgxYU4XZciWofcxJ2V7pYunqrkj4VHbTK6w
	FwdXNfk5T8zaRbQS7DgOsRUqdt/jTpvp0pkHVvU=
X-Seznam-DomainKeys: unknown
X-Seznam-SPF: neutral
X-Virus-Info: clean
Received: from [10.0.3.100] (188-120-198-113.luckynet.cz [188.120.198.113])
	by email-relay1.go.seznam.cz (Seznam SMTPD 1.2.14@16206) with ESMTP;
	Mon, 03 Jan 2011 01:39:01 +0100 (CET)  
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <201012271304.03915.jnareb@gmail.com>
X-Smtpd: 1.2.14@16206
X-Seznam-User: grajcar1@seznam.cz
X-Session: 4194
X-Country: CZ
X-QM-Mark: email-qm3<451543857>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164428>

On 10-12-27 13:04, Jakub Narebski wrote:
> On Wed, 22 Dec 2010, Maaartin-1 wrote:
>> On 10-12-21 14:06, Jakub Narebski wrote:
>>>
>>> Please try to not cull Cc list (use 'reply via email', if possible)
>>
>> I don't know what "cull" means and
>> http://dictionary.reference.com/browse/cull
>> doesn't help me at all. Could you explain?
> 
> http://en.wiktionary.org/wiki/cull
> 
>   to cull
>   [...]
>   3. To select animals from a group and then kill them in order to
>      reduce the numbers of the group in a controlled manner.
> 
> In the context ("to cull Cc list") it means removing entries from Cc
> list (courtesy copy, copy-to), i.e. not replying to all people
> participating in given (sub)thread.

I was using the gmane page, which did it. Next time I replied using
email, but forgot to add the CC. There are things I hate more than
mailing lists, but they're fairly rare.

>> IMHO, it's quite broken. Alone it would be fine, but should really
>> git-show-ref behave that different from git-symbolic-ref?
> 
> git-symbolic-ref is about querying and manipulating _single_ symbolic
> reference, using fully qualified branch names (ref names).

OK, this is a sort of acceptable.

> git-show-ref is about querying multiple refs; I think the design goal
> behind its strange pattern matching semantic is to make it easy to get
> all refs with the same short name.

OK, the strange pattern matching is not that bad.

>> Moreover, git-show-ref --head shows all branches and tags, this can't be
>> right, can it? According to your above explanation, getting HEAD using a
>> pattern is impossible, so I'd say that's what is "--head" good for.
>>
>> Moreover, "git-show-ref --heads" shows less than "git-show-ref --head",
>> despite the plural.
> 
> "git show-ref --head" is strange in that it doesn't play well
> with '--heads' and '--tags' and '<pattern>'.
> 
> I think it is a bit of misdesign, but I don't know how it should be
> fixed; current output of "git show-ref --head" has to be kept because
> of backward compatibility - git-show-ref is plumbing.

I wonder what
git show-ref --head
really does. It seems to output everything, is this the expected (albeit
strange) behavior? Maybe, I know now, s. below.

For sure, either the doc is completely wrong or the implementation. I
hope I understand "Show the HEAD reference" correctly as showing the
HEAD reference, don't I? So it must show a single reference (singular).
Instead I get all tags and all heads. Could anybody either fix the doc
or convince me that the many lines I'm seeing are a single one?

Shouldn't there be an option *really* doing what --head is expected and
documented to do? I mean something like
git show-ref --head --yes-I-really-mean-the-head
with the output consisting of a single line like
4ba2b422cf3cc229d894bb31c429c0c588de85c0 HEAD
Maybe it could be called --head-only.

It could help a lot to add the word "additionally" to the doc like
--head
Additionally show the HEAD reference.

>>> I tripped over strange git-show-ref <pattern> semantic too.
>>>
>>> P.S. there is also git-for-each-ref.
> 
> I don't know why there is git-show-ref when we have git-for-each-ref
> for scripting; I guess they were added nearly at the same time...

I guess, I can get the single line I wanted using
git for-each-ref $(git symbolic-ref HEAD)
right?
