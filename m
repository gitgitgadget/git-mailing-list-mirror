From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 09/32] index: make narrow index incompatible with older git
Date: Wed, 25 Aug 2010 10:25:37 +1000
Message-ID: <AANLkTinMu_jdT2k=NCX3gwVKeMo63jte_K68PjkFGtQi@mail.gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
	<1282688422-7738-10-git-send-email-pclouds@gmail.com>
	<20100824234301.GG2376@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 02:25:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo3oT-0007fi-8m
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 02:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755609Ab0HYAZl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 20:25:41 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37953 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755569Ab0HYAZj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 20:25:39 -0400
Received: by wwb34 with SMTP id 34so28173wwb.1
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 17:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KuAUzGjt/KLgb/wlbojHq36SqDiV0tzIxiYWs5QzulE=;
        b=hbWiOPJ9NP0QBt/FP6JN+HtMN61VffoS1V5MMlZ14jChKyaf9CjwtqHRsAgiEfyAkM
         Iy0+Ui2dmxchqyubdtrNV0yfVmV/RoEh4WmpLqdIsaTW89A1viaME43W17au1QDrso5E
         T68GFLW1oj7sjqGUGsf1GlijcIw4KxcNWya7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KemVKHdfC5PeO5t9oQqgU20HJDk09/lOmCiq5xmiHJRXEOUNX/hqZ1+jRUmGpKW9Lg
         +9iVoLOb0R9y/hvqugNHTbQcOFTM1JmxUboIHYJjwDzajLxHVkWtRurMtNPp0oFoPN46
         yH9AtsqthgVzg6E68osuI03g9qcoqhpc21/pM=
Received: by 10.216.9.3 with SMTP id 3mr6652895wes.66.1282695937806; Tue, 24
 Aug 2010 17:25:37 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Tue, 24 Aug 2010 17:25:37 -0700 (PDT)
In-Reply-To: <20100824234301.GG2376@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154387>

On Wed, Aug 25, 2010 at 9:43 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> Index in narrow repos is not a full index and should not be used
>> to create commits without modification (to be explained later on).
> [...]
>> +++ b/read-cache.c
>> @@ -25,8 +25,9 @@ static struct cache_entry *refresh_cache_entry(str=
uct
>> cache_entry *ce, int reall
>> =C2=A0 */
>>
>> =C2=A0#define CACHE_EXT(s) ( (s[0]<<24)|(s[1]<<16)|(s[2]<<8)|(s[3]) =
)
>> -#define CACHE_EXT_TREE 0x54524545 =C2=A0 =C2=A0/* "TREE" */
>> +#define CACHE_EXT_TREE 0x54524545 =C2=A0 =C2=A0 =C2=A0/* "TREE" */
>> =C2=A0#define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
>> +#define CACHE_EXT_NARROW 0x4e415257 =C2=A0 =C2=A0/* "NARW" */
>
> Just curious: why aren't we using
>
> =C2=A0#define CACHE_EXT_TREE CACHE_EXT("TREE")
> =C2=A0#define CACHE_EXT_RESOLVE_UNDO CACHE_EXT("REUC")
> =C2=A0#define CACHE_EXT_NARROW CACHE_EXT("NARW")
>
> Are they invalid case labels?
>
> I think non-optional extensions might need to be lowercase ("narw")
> though I am not sure.

No idea. I need to dig into history to figure it out later.
--=20
Duy
