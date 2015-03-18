From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Seems to be pushing more than necessary
Date: Wed, 18 Mar 2015 18:42:24 +0700
Message-ID: <CACsJy8DdjDnacVGU83iUDj5Na1xxS6kNDbK2D0Apfv0LAuzDvA@mail.gmail.com>
References: <CAABECY3HbZ4q3uo82outUmCyQLXO39H+Fd2m8bLwkaubE9gJCw@mail.gmail.com>
 <CAABECY1_L34sq0VPmD9UwRcwb3Fuh95OFcF26LM2eX1z-+8vkQ@mail.gmail.com>
 <CACsJy8Au48iFoC=Eo4T-fm6r6tA7VffRJyH2JbuC==wa61=G5A@mail.gmail.com> <CAABECY2_MQWAkOu=6rR=mN=wKz-Yfzsu8o2+wb6F+h4FjBe9Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Graham Hay <grahamrhay@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 12:43:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYCNH-0001My-UY
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 12:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755638AbbCRLmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 07:42:55 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36007 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521AbbCRLmz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 07:42:55 -0400
Received: by iegc3 with SMTP id c3so35861581ieg.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 04:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fo3vDtjshTXCNYV3yuc1SSuJIEA+Z1G4qqnZQPGanZs=;
        b=lu0e2GJuRyJqrU9t5XMFlokO1QxAqtam2KtaTKoTfryqzocW+LB1c3teT2PdraZq0I
         COOY4ProZCL5UvFAWzg3s0sLqYbvU3mp94QcWXilcRz+qUbJ2QPQEvDyE1y6XgYaa4hb
         zulYEhtoLakSVk6GrV1j1uce74zRAdDLLlL4x/pSAPgNcvSjPALWR+Ct8DW2d95zG0OI
         LfkJaWfTh5MSfcJulmMVqtSzjfRriGcM2oCLjbv+o1UUE21SWvbdPHEb62e08J1/NsXx
         yAvIdh4jFd+iMaquDdrZhT+mvuf0nLs65Gs/DY50M92yJgGmSlH4Zw15kVakt4tOvNkp
         H7hg==
X-Received: by 10.50.253.12 with SMTP id zw12mr5847154igc.24.1426678974399;
 Wed, 18 Mar 2015 04:42:54 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Wed, 18 Mar 2015 04:42:24 -0700 (PDT)
In-Reply-To: <CAABECY2_MQWAkOu=6rR=mN=wKz-Yfzsu8o2+wb6F+h4FjBe9Mw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265720>

On Wed, Mar 18, 2015 at 6:26 PM, Graham Hay <grahamrhay@gmail.com> wrote:
>> It would help if you pasted the push output. For example, does it stop
>> at 20% at the "compressing objects" line or "writing objects". How
>> many total objects does it say?
>
> It rattles through "compressing objects", and the first 20% of
> "writing objects", then slows to a crawl.
>
>     Writing objects:  33% (3647/10804), 80.00 MiB | 112.00 KiB/s

This 10804 looks wrong (i.e. sending that many compressed objects).
Also "80 MiB" sent at that point. If you modify just a couple files,
something is really wrong because the number of new objects may be
hundreds at most, not thousands.

v2.2.2 supports "git fast-export --anonymize" [1] to create an
anonymized "clone" of your repo that you can share, which might help
us understand the problem.

There's also the environment variable GIT_TRACE_PACKET that can help
see what's going on at the protocol level, but I think you're on your
own because without access to this repo, SHA-1s from that trace may
not make much sense.

[1] https://github.com/git/git/commit/a8722750985a53cc502a66ae3d68a9e42c7fdb98
-- 
Duy
