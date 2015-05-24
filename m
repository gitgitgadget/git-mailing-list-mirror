From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 2/2] git-p4: fix handling of multi-word P4EDITOR
Date: Sun, 24 May 2015 10:28:02 +0100
Message-ID: <556199A2.8090802@diamand.org>
References: <1431019501-30807-1-git-send-email-luke@diamand.org>	<1431019501-30807-3-git-send-email-luke@diamand.org>	<xmqqr3qsp8a0.fsf@gitster.dls.corp.google.com>	<554BBCBE.1020408@diamand.org>	<xmqqlhh0nny1.fsf@gitster.dls.corp.google.com>	<554BCE25.5070308@diamand.org>	<xmqqa8xgnlme.fsf@gitster.dls.corp.google.com>	<xmqq3838nl5l.fsf@gitster.dls.corp.google.com>	<554BE15B.3040303@diamand.org> <xmqqtwvom3t4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Chris Lasell <chrisl@pixar.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 24 11:29:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwSDO-0001UO-1V
	for gcvg-git-2@plane.gmane.org; Sun, 24 May 2015 11:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbbEXJ2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2015 05:28:45 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38807 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbbEXJ2n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2015 05:28:43 -0400
Received: by wichy4 with SMTP id hy4so24569889wic.1
        for <git@vger.kernel.org>; Sun, 24 May 2015 02:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=4kyhJNo9iR8wvTrZQydt1eWKGIeuEm5lAanW6j1m2iQ=;
        b=iwgoalPvLVjJbuFCif0DhcFCscON1af9hA4Ro2Xukesph58v0fd6sHad/rIuvWVFZ8
         mA19IpbyH9lcdverGmpaoCWtGkHodZLqAdQJ2edmpRpokcS/BlFInUap2BEOMsSJq9AM
         diUduj5cujuo9iuuOoVa/fzDoJLm3rjJtj9BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=4kyhJNo9iR8wvTrZQydt1eWKGIeuEm5lAanW6j1m2iQ=;
        b=EoTMdvZZFsDktsBXDbmJaxq6pAFbAmoeHXIYLItgSSc/xxgzTJNQOY02BwMRS4Xwdo
         bE2zbsbhwbY5sR5BEYf3I8J7QaO4Qb6huBP/We6SMl15mCKQvAblo6qXPOK8bKFKzgg0
         /SRj9a2Z79ZgwvNmadGjwnBbV9EbFMpcxXTX4yNKXGj8L9B7CUNnDcgygenfJQD/wufS
         9nEf6PgmDZMJn3k3orfvZdujzH2/NcDLaOjf7rS/B2UrlF3STabYb/hwVFWMv8+zC0jj
         eCUuoV+ugd4rSdM4BAlqc+ccI2OKwL5NcSRJyKfdBEnPro9aN8AjSrKg2nurCuYDUkjZ
         4rIg==
X-Gm-Message-State: ALoCoQnVhAt0dHancttW8WQdtoeD4joDXrepadOPV5F4dO/TRXavvmzWZ302MTzM/0hFu497bLEc
X-Received: by 10.180.7.133 with SMTP id j5mr17472653wia.84.1432459722497;
        Sun, 24 May 2015 02:28:42 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id ef10sm11289568wjd.49.2015.05.24.02.28.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 May 2015 02:28:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <xmqqtwvom3t4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269828>

On 07/05/15 23:16, Junio C Hamano wrote:
> Luke Diamand <luke@diamand.org> writes:
>

[Resurrecting old thread]

>
> Looking at run-command.c, GIT_WINDOES_NATIVE and POSIX seems to use
> pretty much the same construct, except that they use SHELL_PATH
> instead of "sh".

I think the state of git on Windows is a bit shaky (I'm happy to be 
proved wrong of course), but I think the only seriously active port is 
the msys one.

That, as far as I can tell, uses an msys version of 'sh', so it will be 
perfectly happy with the "sh -c ..." construct.

There may be a native windows port in existence, but I can't find how to 
build this, and I assume it's going to need Visual Studio, which makes 
it a lot more complex to get going.

The code you were looking at in run-command.c says this:

#ifndef GIT_WINDOWS_NATIVE
		nargv[nargc++] = SHELL_PATH;  <<<<< !GIT_WINDOWS_NATIVE
#else
		nargv[nargc++] = "sh";        <<<<< GIT_WINDOWS_NATIVE
#endif
		nargv[nargc++] = "-c";

To me, that seems to imply that for GIT_WINDOWS_NATIVE, we take the 
*second* branch and use "sh", so again, the the code as it stands will 
be fine. msysgit uses that path.

(The next line, trying to use "-c" has no chance of working if Cmd is 
being used).


>
> So something like this may be sufficient, perhaps?
>
>   Makefile  | 1 +
>   git-p4.py | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 20058f1..fda44bf 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1776,6 +1776,7 @@ $(SCRIPT_PYTHON_GEN): GIT-CFLAGS GIT-PREFIX GIT-PYTHON-VARS
>   $(SCRIPT_PYTHON_GEN): % : %.py
>   	$(QUIET_GEN)$(RM) $@ $@+ && \
>   	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
> +	    -e 's|SHELL_PATH|$(SHELL_PATH_SQ)|g' \
>   	    $< >$@+ && \
>   	chmod +x $@+ && \
>   	mv $@+ $@
> diff --git a/git-p4.py b/git-p4.py
> index de06046..eb6d4b1 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1220,7 +1220,7 @@ class P4Submit(Command, P4UserMap):
>               editor = os.environ.get("P4EDITOR")
>           else:
>               editor = read_pipe("git var GIT_EDITOR").strip()
> -        system(["sh", "-c", ('%s "$@"' % editor), editor, template_file])
> +        system(['''SHELL_PATH''', "-c", ('%s "$@"' % editor), editor, template_file])

This seems to be expanded to '''sh''' which doesn't then work at all. I 
didn't take the time to investigate further though.

>
>           # If the file was not saved, prompt to see if this patch should
>           # be skipped.  But skip this verification step if configured so.

I don't think we need to do anything. msysgit works fine with the origin 
"sh", "-c", ... code.

Thanks!
Luke
