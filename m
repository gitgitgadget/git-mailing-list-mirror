From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [PATCH 01/14] Fix non-constant array creation
Date: Fri, 21 Aug 2009 15:46:35 +0200
Message-ID: <4A8EA53B.9080809@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>	 <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com> <40aa078e0908210641m660b003do6f637535293672ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 15:46:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeUS8-00089Q-HK
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 15:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272AbZHUNqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 09:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754558AbZHUNqj
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 09:46:39 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:34327 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932087AbZHUNqj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 09:46:39 -0400
Received: by ewy3 with SMTP id 3so648431ewy.18
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 06:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=SfYScJ9lZgsQhNU7SEAahqF+Y5YZy65eAXYQZ5kmoK4=;
        b=hz7Y005pgkvYy0Neo/8SVDwVBEH5CqJCzvhh7l63vcuZK6rg+llk6q+xvPS4Jq8FTf
         QDPjDau3R/VdfN/V6IdcBUnkneueQgg4uw61E8T6GnUsfcZFZWpMVHAl/ni/pw5/a+Iw
         TiPJUuypi1AIxCeSlRMvVgZ5GhKcgtRhcKKK4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=xC40orqjGv/jAL0ESpKrT3hftO5h2qRPaNDpMvQvjewWhaBhZ/7I4/XKhQQtE6kDGl
         pN+dNuCEU4+bz5I9CXZDOraWOfy1G5k6b5+evT6bA2H5vCiy3lMG9xc8vSpwLBk8usCD
         7CtFJK851O4aqNndrysL4VlyRxAdy+v74FQBU=
Received: by 10.210.128.17 with SMTP id a17mr1517827ebd.38.1250862399890;
        Fri, 21 Aug 2009 06:46:39 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 5sm2487036eyf.18.2009.08.21.06.46.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 06:46:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.22) Gecko/20090605 Lightning/0.9 Thunderbird/2.0.0.22 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <40aa078e0908210641m660b003do6f637535293672ae@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126725>

Erik Faye-Lund said the following on 21.08.2009 15:41:
> On Fri, Aug 21, 2009 at 3:30 PM, Marius Storm-Olsen<mstormo@gmail.com> wrote:
>> @@ -1875,7 +1875,7 @@ static int match_fragment(struct image *img,
>>                size_t imgoff = 0;
>>                size_t preoff = 0;
>>                size_t postlen = postimage->len;
>> -               size_t imglen[preimage->nr];
>> +               size_t *imglen = xmalloc(sizeof(size_t) * preimage->nr);
> 
> How about using alloca instead? It allocates from the stack (just like
> the C99-style variable-length array you're replacing), and you don't
> need to free the memory afterwards.
> 
> ... or is alloca frowned upon? I see it's already used both in
> compat/regex/regex.c and in compat/nedmalloc/malloc.c, but not
> apparently not in the git core.

MSVC compiles regex.c, so it must handle it. I'm fine with that.

--
.marius
