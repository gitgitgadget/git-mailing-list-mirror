From: Bryan Turner <bturner@atlassian.com>
Subject: Re: http-protocol question
Date: Tue, 2 Dec 2014 15:29:43 +1100
Message-ID: <CAGyf7-GpPiMCj8=ewjVGv5Hkip__ysR_gs20rG4dTvDbEdd2RQ@mail.gmail.com>
References: <CAGyf7-HmvvHQZkyLgKAs2rrZTTLFkBa8s828hbS9LedLNb2fWA@mail.gmail.com>
	<20141202033416.GY6527@google.com>
	<CAGyf7-GZbRBN4O_yNgrmJCya=6f8XQ4O8m7WBa1k8Ve196ajYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 05:29:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvf5x-0000Qh-Qm
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 05:29:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932974AbaLBE3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 23:29:45 -0500
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:35576 "HELO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932968AbaLBE3o (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Dec 2014 23:29:44 -0500
Received: from mail-oi0-f51.google.com ([209.85.218.51]) (using TLSv1) by na3sys009aob107.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVH1AOKfdMNnY5Id8tIbJTIksQ7OGFMk6@postini.com; Mon, 01 Dec 2014 20:29:44 PST
Received: by mail-oi0-f51.google.com with SMTP id e131so8586845oig.24
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 20:29:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=RMaDGBysd8JrcWARNcuGRI9NBiUJ/XJr4gey/3rnYmA=;
        b=gN6sJUMvsdGOyoKzEn898ncGNngrkqRlYab7aDZ7kknHyQ8H5s5CwrM2knC7qlNxUg
         CMsB6AaqSRhL6xFbX27zphTHYbO1AD6mksTPwGhnbifNsjVMV+v2oqer0g9LM7y6Ra+1
         ldiDRskz3h2MsqPRvETcvBRH8OaCKSRhm3Pl1RwRUB3Mpj8MKby+1PrhEKM9PIrRgctz
         oXxO/so+UQAltQOJ5UuF7n/sP3tzixupzi99cGSJyexgCJKEi+AdbGsnxzA+cBroYGXu
         ERnjsd7I/LaYWG3TayWD0yxs6cdhkLAPkVGRk/yjfPUoi96V2tQtDcnfJ9JL9S12jECB
         OSIA==
X-Gm-Message-State: ALoCoQncJ0JudjBDXEXIJGsek4lFnpvm67RR4x5b5b8XPNTIBNT06Nzql4khgBctXQBWQyNuAPsuGdtmARF2By5Z5AG5690lxCtLgzP+7A2bho+Oh00gLpJFEw5ETJsVtoO6b4FloyIe9Vvr75WlL71g59IJu+s7Gg==
X-Received: by 10.60.58.33 with SMTP id n1mr37942331oeq.85.1417494583792;
        Mon, 01 Dec 2014 20:29:43 -0800 (PST)
X-Received: by 10.60.58.33 with SMTP id n1mr37942328oeq.85.1417494583709; Mon,
 01 Dec 2014 20:29:43 -0800 (PST)
Received: by 10.182.245.170 with HTTP; Mon, 1 Dec 2014 20:29:43 -0800 (PST)
In-Reply-To: <CAGyf7-GZbRBN4O_yNgrmJCya=6f8XQ4O8m7WBa1k8Ve196ajYQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260530>

On Tue, Dec 2, 2014 at 3:28 PM, Bryan Turner <bturner@atlassian.com> wrote:
> On Tue, Dec 2, 2014 at 2:34 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Hi Bryan,
>>
>> Bryan Turner wrote:
>>
>>> Is there actually logic somewhere in Git that does that "MAY walk
>>> backwards" step?
>>
>> Yes.  See upload-pack.c::check_non_tip and
>> http://thread.gmane.org/gmane.comp.version-control.git/178814.
>
> Jonathan,
>
> Thanks for the reply! I realize now I didn't really cite the part of
> that documentation that I'm most interested in, which is: "through
> history _or through the reflog_". It's the reflog bit I'm looking for.
> Sorry for not being more clear. check_non_tip appears to look at
> ancestry, walking back up (or down, depending on your view) the DAG to
> see if the requested SHA-1 is reachable from a current ref, so it
> looks like that's covering the "through history" part of that blurb.
>
> The reason I ask is that there is a race condition that exists where
> the ref advertisement lists refs/heads/foo at abc1234, and then foo is
> deleted before the actual upload-pack request comes in. In that
> situation, walking backwards through _history_ will only allow the
> upload-pack to complete unless the deleted ref was merged into another

s/unless/if, sorry. "In that situation, walking backwards through
history will only allow the upload-pack to complete if the deleted ref
was merged into another ref."

> ref prior to being deleted (if I understand the code correctly). It
> seems like looking at the reflogs, and seeing that refs/heads/foo did
> in fact exist and did in fact refer to abc1234, is the only approach
> that could allow the upload-pack to complete. The documentation hints
> that such a thing is possible, but I don't see any code in Git that
> seems to do that.
>
> Does that make more sense? Does that functionality exist and I've just
> overlooked it?
>
> Thanks again,
> Bryan Turner
>
>>
>> Hope that helps,
>> Jonathan
