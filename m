From: Paul Campbell <pcampbell@kemitix.net>
Subject: Re: [PATCH v2 05/23] contrib/subtree: Add commands pull_all and push_all
Date: Mon, 11 Mar 2013 11:49:14 +0000
Message-ID: <CALeLG_=JbuZJs3dt26aS+kNMyZKC=kBXs4+OMpdQ7fC0nUyTAQ@mail.gmail.com>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
	<1362958891-26941-6-git-send-email-pcampbell@kemitix.net>
	<7vk3pebkac.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, David Greene <greened@obbligato.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 11 12:49:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF1Ee-0001Px-BG
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 12:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028Ab3CKLtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 07:49:17 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:58899 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886Ab3CKLtP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 07:49:15 -0400
Received: by mail-ob0-f177.google.com with SMTP id eh20so3138865obb.8
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 04:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=PABVGNdu22p9g+8BD3YrBJsqZ0+ZGCSwAUtdDcwR4N8=;
        b=i9O86cLPViaNt0lzya9KQyolX8fYk3eFN5vNoEzaYYvaKCDNfCGc0Wy6FqkXnoaCNu
         N8Bee7fPEf/YNLaZYMRJlJwk1KrnmYZag2h39qJaSHUJU4JbkeZ6yfkVqGhx0rY/cH92
         pq+NstS2BIOELI7Mhklrm9pe1ayWD+lWxFZPbALgOBIbGx9Om8hxqROi0DAExKct6F2a
         gAclzY4c+MoHAhfR8TnC4+Kn87b8NwkZfesSVjOJZaiUYjqhkkpdop0FmoDHIBB9GpmA
         Xuf1S7rR5fo/fiGaOv2VZ6TQcXk3Cb+WTHhosk4DeOMLgCUX1yCSnXMWoqfp0Wm7Noca
         +eKg==
X-Received: by 10.182.93.193 with SMTP id cw1mr8187227obb.93.1363002555142;
 Mon, 11 Mar 2013 04:49:15 -0700 (PDT)
Received: by 10.76.122.109 with HTTP; Mon, 11 Mar 2013 04:49:14 -0700 (PDT)
X-Originating-IP: [212.219.195.16]
In-Reply-To: <7vk3pebkac.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQlhJdXadYtRsGZxCqjV3iIf6xKp/VHGW0VSk1k8yQq+e6a9Ajs7XlpRLtH1lZNexiv6fhbV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217868>

On Mon, Mar 11, 2013 at 5:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Campbell <pcampbell@kemitix.net> writes:
>
>> From: bibendi <bibendi@bk.ru>
>>
>> For each subtree listed in .gittrees perform a push or a pull.
>>
>> Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
>>
>> Conflicts:
>>       contrib/subtree/git-subtree.sh
>
> The "Conflicts:" part is totally irrelevant.  Please remove.
>
>> ---
>>  contrib/subtree/git-subtree.sh | 25 ++++++++++++++++++++++---
>>  1 file changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
>> index 1aff956..ddae56e 100755
>> --- a/contrib/subtree/git-subtree.sh
>> +++ b/contrib/subtree/git-subtree.sh
>> @@ -12,6 +12,7 @@ git subtree add   --prefix=<prefix> <commit>
>>  git subtree add   --prefix=<prefix> <repository> <commit>
>>  git subtree merge --prefix=<prefix> <commit>
>>  git subtree pull  --prefix=<prefix> <repository> <refspec...>
>> +git subtree pull_all
>
> Why isn't it "pull --all"?
>
>>  git subtree push  --prefix=<prefix> <repository> <refspec...>
>
> Where did "push_all" go?
>
>> +cmd_pull_all()
>> +{
>> +    git config -f .gittrees -l | grep subtree | grep path | grep -o '=.*' | grep -o '[^=].*' |
>
> "grep -o" is not even in POSIX.  Besides, what is this trying to
> parse?  Is it expected to match lines like
>
>         path.subtree=trash
>
> with this, or is it more like you only want something like this:
>
>         subtree.over/there.path=foo
>
> in which case you would want to read with something like
>
>         sed -n -e 's/^subtree\...*\.path=\(.*\)/\1/p'
>
> instead (modulo the usual caveat on $IFS whitespaces in path)?
>
>> +        while read path; do
>> +            git subtree pull -P $path master || exit $?
>> +        done
>> +}
>
> I'd stop looking at this series myself at this step for now.

Thanks for your feedback. Plenty there for me already to get cracking on.

-- 
Paul [W] Campbell
