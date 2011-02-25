From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 8/8] trace: give repo_setup trace its own key
Date: Fri, 25 Feb 2011 13:38:25 +0700
Message-ID: <AANLkTimC2gv4GjA6YT7H9KuPcwOApkPxRcbDEOvvv9M8@mail.gmail.com>
References: <20110224142308.GA15356@sigill.intra.peff.net> <20110224143030.GH15477@sigill.intra.peff.net>
 <20110224214959.GH17412@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 07:39:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsrKb-000179-43
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 07:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538Ab1BYGi5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 01:38:57 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60242 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938Ab1BYGi4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 01:38:56 -0500
Received: by wwb39 with SMTP id 39so1764789wwb.1
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 22:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=KGL9EAfhkcQMeQeUCo6t2UNkEfEQn/slAqtf2+pk6qQ=;
        b=QoQ2CWIMJOHLPRH1arJ1CLuoL9FfK6AsPaQutwN02K84gU+VS24Yp+Lu2gcsGOltLN
         9XCcTNmmE47mT3zL5vfrNPAwn/K4tWk3KMEh6+Rt54fMh7ZkKPZ+sRWv5O6rDWZRkSna
         ogfWHJ9K8MOzE2/2I7VM5tkpaqyv+ReCLUJYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=MjyKmR6IZznFH2pGZX9XE4gq75GWStHDOBvtLJfNpPjnQ8Q3bxOT0bidXEV1qhn0lb
         NEsrByKiXLVkrx2q/a3CVfl88t6YJmwDI+DYfVmvMpJFWAfne3WCJXk+IddBsgE4V8Ru
         rVLroQ0OfPcmIDajt9wPTIhF/gVHYAiAIgzsc=
Received: by 10.216.185.142 with SMTP id u14mr6744215wem.31.1298615935091;
 Thu, 24 Feb 2011 22:38:55 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Thu, 24 Feb 2011 22:38:25 -0800 (PST)
In-Reply-To: <20110224214959.GH17412@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167876>

On Fri, Feb 25, 2011 at 4:49 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Jeff King wrote:
>
>> You no longer get this output with GIT_TRACE=3D1; instead, you
>> can do GIT_TRACE_SETUP=3D1.

Minor note. GIT_TRACE warning in test-lib.sh will need improvement for
checking GIT_TRACE_*

>> @@ -170,10 +171,10 @@ void trace_repo_setup(const char *prefix)
>> =C2=A0 =C2=A0 =C2=A0 if (!prefix)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prefix =3D "(null)"=
;
>>
>> - =C2=A0 =C2=A0 trace_printf("setup: git_dir: %s\n", quote_crnl(get_=
git_dir()));
>> - =C2=A0 =C2=A0 trace_printf("setup: worktree: %s\n", quote_crnl(git=
_work_tree));
>> - =C2=A0 =C2=A0 trace_printf("setup: cwd: %s\n", quote_crnl(cwd));
>> - =C2=A0 =C2=A0 trace_printf("setup: prefix: %s\n", quote_crnl(prefi=
x));
>> + =C2=A0 =C2=A0 trace_printf_key(key, "setup: git_dir: %s\n", quote_=
crnl(get_git_dir()));
>> + =C2=A0 =C2=A0 trace_printf_key(key, "setup: worktree: %s\n", quote=
_crnl(git_work_tree));
>> + =C2=A0 =C2=A0 trace_printf_key(key, "setup: cwd: %s\n", quote_crnl=
(cwd));
>> + =C2=A0 =C2=A0 trace_printf_key(key, "setup: prefix: %s\n", quote_c=
rnl(prefix));
>
> I wonder if it would make sense for this to be
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_printf("setup", "git_dir: %s\n", ...=
);
>
> and:
>
> =C2=A0- automatically prefix each line with the key instead of "trace=
:"
> =C2=A0- enable or redirect based on the content of the GIT_TRACE_$(uc=
 $key)
> =C2=A0 variable

Yeah I think it's nice to have key =3D "setup", then env name becomes
GIT_TRACE_$(uc $key) and prepend "$key: " in all trace messages.
--=20
Duy
