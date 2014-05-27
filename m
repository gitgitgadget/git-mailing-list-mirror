From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/5] commit test: Change $PWD to $(pwd)
Date: Tue, 27 May 2014 02:10:48 -0400
Message-ID: <CAPig+cTRF5NFUagF6mLbBduJe8TgACTHdc7CbK_QRehZ-2DXqw@mail.gmail.com>
References: <20140525062427.GA94219@sirius.att.net>
	<1401130586-93105-1-git-send-email-caleb@calebthompson.io>
	<1401130586-93105-3-git-send-email-caleb@calebthompson.io>
	<538426D3.8090107@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Caleb Thompson <cjaysson@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue May 27 08:10:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpAb7-0003ph-2f
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 08:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbaE0GKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 02:10:49 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:58185 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbaE0GKt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 02:10:49 -0400
Received: by mail-yh0-f42.google.com with SMTP id t59so7154426yho.29
        for <git@vger.kernel.org>; Mon, 26 May 2014 23:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=X776GGMCyjYzqOG3LDtM1XKEMmKsPZbCi+XMwlBiex8=;
        b=xACaS+9OPxBrelQaVWLAouXHouffgEe/otTrKsOS/s4Sv+iL3nZ87N+p8DPTAzLXzo
         xlO9iS1rv/HNf6LVXbkavYHaU0uxF/x/cahY7pFagvElQtofftRxBs0/2OXfXNDw+20J
         L7/dC3zvfWzaXjCdGB9fMxtRfGgwfn6fMo8q4VpNvSti2yWBFNZGEsoMEwqB7eVv9XIi
         qbG3UBYBJ/Id3Qe/muEAKu3CLnQiw0S/AXhgKWkOnMtWYdH1dvqqrK/XdETdE/oERFYD
         vrGmxsvpxzB5E34mkveMv6gHX4fokzn8IWOlbbD7w8xnz3GlWB6Xwhw8G5ASkSLx6HV/
         YZtg==
X-Received: by 10.236.101.198 with SMTP id b46mr42919031yhg.68.1401171048353;
 Mon, 26 May 2014 23:10:48 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Mon, 26 May 2014 23:10:48 -0700 (PDT)
In-Reply-To: <538426D3.8090107@viscovery.net>
X-Google-Sender-Auth: CecXo_rvFtT352x9ZLKpPuVE7Zc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250142>

On Tue, May 27, 2014 at 1:46 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 5/26/2014 20:56, schrieb Caleb Thompson:
>> Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
>> ---
>>  t/t7507-commit-verbose.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
>> index 6d778ed..3b06d73 100755
>> --- a/t/t7507-commit-verbose.sh
>> +++ b/t/t7507-commit-verbose.sh
>> @@ -8,7 +8,7 @@ cat >check-for-diff <<EOF
>>  exec grep '^diff --git' "\$1"
>>  EOF
>>  chmod +x check-for-diff
>> -test_set_editor "$PWD/check-for-diff"
>> +test_set_editor "$(pwd)/check-for-diff"
>>
>>  cat >message <<'EOF'
>>  subject
>
> Why? I see no benefit. Both $PWD and $(pwd) work fine everywhere,
> including Windows, and the former is faster, particularly on Windows.

Poor advice on my part when reviewing the previous round. When I had
read in git/t/README (in the distant past):

    When a test checks for an absolute path that a git command
    generated, construct the expected value using $(pwd) rather than
    $PWD, $TEST_DIRECTORY, or $TRASH_DIRECTORY. It makes a difference
    on Windows, where the shell (MSYS bash) mangles absolute path
    names.  For details, see the commit message of 4114156ae9.

I must have missed the word "check" in the first sentence.
