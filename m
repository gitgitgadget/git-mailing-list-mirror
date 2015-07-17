From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] gitk: Add a "Copy commit summary" command
Date: Fri, 17 Jul 2015 10:28:07 -0700
Message-ID: <xmqqwpxy1yoo.fsf@gitster.dls.corp.google.com>
References: <205a18f7f8a7892a1fa63a91a84bfd9b@drbeat.li>
	<CAPig+cR=u_ak_=J=gSAWfiNB01R7FBG+bCrx+k1HNAE0xHtwFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Beat Bolli <dev+git@drbeat.li>, Git List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 19:28:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG9Qs-0004iO-B7
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 19:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755480AbbGQR2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 13:28:11 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33102 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755425AbbGQR2J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 13:28:09 -0400
Received: by pdbqm3 with SMTP id qm3so64949091pdb.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 10:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Qa+xMd57hOe9lx+5BS6rsAM8UTnSXc2Zw3ECJVtypiA=;
        b=xvTUjRaueUeszqvtzHPIEjyCSQgaqiTIvj4EYEIo3XhlobHAasNldMpnAESdg7NZyd
         s1JOvf/xtqm4I8JqdJ05zwZ3lBxVtu1HfmeyIVt9zKfO+R89+7GXhIpRY/ZEBMb2jYnY
         by8C4HyeBo8vXJM62mAHuvKMCGLTcJ7Jgc3o+O4X/oF1i0MgM1iVrOlH/szNVyA83nEg
         zqPOsHw0LnvlYvO5rGyBf6JzTrnMcoUB9Da5gQ4o/pwYkVF6baIEHnRdBRDPywwrLfS3
         zmHenG1cw50BLqiZ0g5G1Wf+uGJjupS87v4a748whvIHLxQmCO3SWZoj0koC3yTyRFYw
         1Wng==
X-Received: by 10.70.42.233 with SMTP id r9mr31439355pdl.140.1437154089148;
        Fri, 17 Jul 2015 10:28:09 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id m3sm11867564pdd.29.2015.07.17.10.28.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 10:28:08 -0700 (PDT)
In-Reply-To: <CAPig+cR=u_ak_=J=gSAWfiNB01R7FBG+bCrx+k1HNAE0xHtwFQ@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 17 Jul 2015 13:17:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274091>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
>> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
>> Reviewed-by: Johannes Sixt <j6t@kdbg.org>
>
> You should drop these Reviewed-by: footers, as they imply that the
> code was thoroughly digested and the implementation deemed correct.

... and the most importantly, the named people said that themselves.

I do not think that happened here (yet).

>> +proc copysummary {} {
>> +    global rowmenuid
>> +
>> +    set format "%h (\"%s\", %ad)"
>> +    set summary [exec git show -s --pretty=format:$format --date=short \
>> +                 $rowmenuid]
>> +
>> +    clipboard clear
>> +    clipboard append $summary
>> +}
>> +

I think this is a reasonable implementation.  The usual "spawning a
process for each commit is too expensive" would not apply, because
it is done on demand only for the single commit that the end-user
specified.
