From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] config.mak.uname: Cygwin: Use renames for creation
Date: Sat, 8 Aug 2015 16:47:46 -0400
Message-ID: <55C66AF2.3060706@gmail.com>
References: <1438979428-5888-1-git-send-email-adam@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Blake <eblake@redhat.com>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 08 22:48:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOB2H-0002gv-HD
	for gcvg-git-2@plane.gmane.org; Sat, 08 Aug 2015 22:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992658AbbHHUru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2015 16:47:50 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33299 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992623AbbHHUrt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2015 16:47:49 -0400
Received: by ykaz130 with SMTP id z130so5821351yka.0
        for <git@vger.kernel.org>; Sat, 08 Aug 2015 13:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=w1TG/URWAFeysoxUfmjQLX/3HAzm0gd2QXaByxkFgRY=;
        b=ModCafTc6bFLVKx690ccTEI+hHHRCZD1v67+5WUNAT7mnA2ou1JL4IYcl6hsuQl+MN
         he0SNEvMZWj+6wDUpIRwFUCQMmGpNON8wh1Dvkza9CJGT1sm0BVqgVdzl64mUWxPG9A7
         lebWCnVWCDka6eVomNYBgIPdFT8QGfdgs/ojpTQcfd6tDyqAyfukaLfYOFY0DVNHTtG7
         iNgTJeA8KXnxf9Q0xXTZlHp1Dxppxvf9zdv8W8LlFRGPM6eV7/acEzbhu5aTcGMBXjrg
         y2zizb0YK7lqh4JnW2Mfv8YXKxEti41OIOvoD9TTWwK5aYfVdnKDHmbZlCJtNDZ5ro6w
         /ucg==
X-Received: by 10.13.238.71 with SMTP id x68mr14720175ywe.129.1439066868966;
        Sat, 08 Aug 2015 13:47:48 -0700 (PDT)
Received: from marklaptop.lan (pool-96-255-220-63.washdc.fios.verizon.net. [96.255.220.63])
        by smtp.gmail.com with ESMTPSA id v188sm13528232ywb.24.2015.08.08.13.47.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Aug 2015 13:47:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <1438979428-5888-1-git-send-email-adam@dinwoodie.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275518>

On 08/07/2015 04:30 PM, Adam Dinwoodie wrote:
> When generating build options for Cygwin, enable
> OBJECT_CREATION_USES_RENAMES.  This is necessary to use Git on Windows
> shared directories, and is already enabled for the MinGW and plain
> Windows builds.
>
> This problem was reported on the Cygwin mailing list at
> https://cygwin.com/ml/cygwin/2015-08/msg00102.html (amongst others) and
> is being applied as a manual patch to the Cygwin builds until the patch
> is taken here.
>
> Reported-by: Peter Rosin <peda@lysator.liu.se>
> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> ---
>   config.mak.uname | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index 943c439..be5cbec 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -187,6 +187,7 @@ ifeq ($(uname_O),Cygwin)
>   	X = .exe
>   	UNRELIABLE_FSTAT = UnfortunatelyYes
>   	SPARSE_FLAGS = -isystem /usr/include/w32api -Wno-one-bit-signed-bitfield
> +	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
>   endif
>   ifeq ($(uname_S),FreeBSD)
>   	NEEDS_LIBICONV = YesPlease
I've been supporting use of git on cygwin since about 2008, this issue 
has never risen that I know. Whatever issue is being patched around 
here, if truly repeatable, should be handled by the cygwin dll as that 
code is focused on providing full linux compatibility. If git on linux 
does need this patch, git on cygwin should not, either. So, I vote 
against this.

Mark
