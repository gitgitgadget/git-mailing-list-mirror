From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Git ignore help
Date: Mon, 23 Mar 2015 21:55:14 -0400
Message-ID: <CAPig+cT5=3kzEu4CzfYW3QtKqDDHn5uSwocoscFLU-T9M-+wiw@mail.gmail.com>
References: <47F.3lxhK.7IviRa5Gutr.1L2}X3@seznam.cz>
	<CAPig+cRU38sNHRsn=8=60wPO_AoQt-zn1dicFHwjG0OK-9tecQ@mail.gmail.com>
	<CACsJy8CGuuRTGycj13cT9d-n=HavzL4LVWC7xjD4Ac=KQGEhBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mdconf@seznam.cz, Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 02:55:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaE3u-0006fa-Iu
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 02:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbbCXBzR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2015 21:55:17 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:35224 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbbCXBzP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2015 21:55:15 -0400
Received: by yhim52 with SMTP id m52so49573837yhi.2
        for <git@vger.kernel.org>; Mon, 23 Mar 2015 18:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=20+4I2RbbWhjbTzZgFsEUifeZXO1181LY64R5Mn/wuw=;
        b=CK7l0nbkXbU/zuUsGcAIn6BwcB7fFE4PXNoPI7vO13TWsEURAOBx84307M3eQPBVI7
         lhY3GW2tN0WdoCHg+tHnSTmVQAZkZJTsj69G23NIJkP+h81+pjt2dOXvRuFuqwy1rIUh
         7QLu+YnnCgn1Jl9toNQCoY5ZY7+2r6Q6Mms7+Uoy5aL8lzfWEdcQ8hD5su/dlGI1BbxP
         HdAH3ykKf9DjeDO12PnbqaYTLn6/qoUJnpFU3hdW/tNZ+ViPNWjS9fXQ3v6sOpLR3E3z
         vtnQjef3BigyQ01JiZ4F4UDhueV6YF4gcH3FYvGGuR7zRrjBV3hl0R/ZrPPAf5wrzXWh
         ifMw==
X-Received: by 10.236.202.98 with SMTP id c62mr1929552yho.166.1427162114425;
 Mon, 23 Mar 2015 18:55:14 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Mon, 23 Mar 2015 18:55:14 -0700 (PDT)
In-Reply-To: <CACsJy8CGuuRTGycj13cT9d-n=HavzL4LVWC7xjD4Ac=KQGEhBg@mail.gmail.com>
X-Google-Sender-Auth: g3GF24Qxt1KgaMCKv0qHfS3OmyQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266173>

On Mon, Mar 23, 2015 at 9:00 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Mar 22, 2015 at 10:33 AM, Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>> On Fri, Mar 20, 2015 at 6:36 AM,  <mdconf@seznam.cz> wrote:
>>> Any idea what I am doing wrong?
>>
>> The fourth bullet point of the "Pattern Format" section of the
>> gitignore man page has this to say, which explains the behavior you'=
re
>> seeing:
>>
>>     An optional prefix "!" which negates the pattern; any matching
>>     file excluded by a previous pattern will become included again.
>>     It is not possible to re-include a file if a parent directory of
>>     that file is excluded. Git doesn=E2=80=99t list excluded directo=
ries for
>>     performance reasons, so any patterns on contained files have no
>>     effect, no matter where they are defined.
>
> This is true. To elaborate, if we have to recurse in excluded
> directories so that we can include some back, then the reason for
> excluding is already defeated as we may need to traverse the entire
> directory structure. However in this particular case where we do know
> in advance that only certain directories may have "re-include" rules,
> e.g. "db", "reports" or "scripts", we could keep going for a while. I
> think I attempted to do this in the past and failed (don't remember
> exactly why). Maybe I'll try again some time in future.

I also was pretty sure that you had attempted this, but couldn't find
a reference to it, so I didn't mention it in my response. However,
with some more digging, I finally located it[1].

[1]: http://article.gmane.org/gmane.comp.version-control.git/259870

> Another option is, if the user is willing to accept performance
> degradation (in many small repos, it does not matter anyway), then we
> could keep digging in.
> --
> Duy
