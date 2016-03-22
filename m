From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] bisect--helper: convert a function in shell to C
Date: Tue, 22 Mar 2016 11:43:43 +0530
Message-ID: <CAFZEwPPh4tru85Lr=8tSZALqPjUrrNsyQvquMhcHjjAsE7REZQ@mail.gmail.com>
References: <010201539a8d2b8a-9f168d7a-d4c6-4c23-a61f-1ef6ee22f774-000000@eu-west-1.amazonses.com>
	<CAGZ79kZveu07h_vERFpJekp4ayJwytwoNVG0LbhiaCnt4u-jRw@mail.gmail.com>
	<CAP8UFD0tSffjJJ-kDdN6aWC6bTP3LJWjtAAFP-1s0qVH_wVx1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 07:14:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiFZw-0001Rt-Hq
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 07:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755706AbcCVGN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 02:13:56 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:34657 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733AbcCVGNu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 02:13:50 -0400
Received: by mail-yw0-f172.google.com with SMTP id h129so242208077ywb.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 23:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=HVBm0/YPV4hdbZAEFBGmgFVmxWlfAPF/QWC7itWEL0Y=;
        b=CDd54KQkXRg3y9Ui6y+xRQuluwL8kjzZwtD5FxYIUoDhy8CONwQJ9+7Vms9pbNKham
         usvmP+i0wdOqzynJ6PUZQzNkj57psBLAn95ezjYwlcKupWI7r/cMQY7hafpCJyRDCrJ1
         E7NbYJo/AwLWAd3X1QwOu5aHCTqKriBxSsKj5rTyyCOLzE+QTVrujWh/eGs3oK4jR7vW
         ap+63ygg3yvRgIBDHBb8GH4PpwYuLbWKSN209/sUjND2lY0j65FzBa0lZii1kTIThYqa
         EKygfmhRsowpS63mkNkgVfFXN1CzsSJefCqvgEl4l5kJQtqKjJ8tjz2HW0mbqNJIdU2v
         7kEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=HVBm0/YPV4hdbZAEFBGmgFVmxWlfAPF/QWC7itWEL0Y=;
        b=RYGE1tsxy530QL06Ro7BI5Y0gNnrSN44Ur9ToJrKKHr2ET0OxZnBo2zeuKsogfrgfv
         Owst694aQpZtxWchxvnT36YIsmmkyup1+noHjk+qlLdeMjM/6zLkaPGNnGQxHsIrh6XB
         of5qF5w5CV617URou5MmAlxDCStQdbBi1PFvyBaWXSMxDOnWbeHOYuzasjbZaE4Bp+eH
         QqytfzOm6igiOshlMLVQtqq/yHwmVc8iB7w8ac6heL7Bl4YMxhQORZPps681gbQDBNIo
         71cXpirtc1QVudgTxgF3MLY0yLPIRBFItf1st4lTkQnsmd/wAZN+AO65mFzCYZd0xv54
         F+Ew==
X-Gm-Message-State: AD7BkJKL4paQV+x+z73NpsqcEH2HaU7SYUdxmEFmzCxkJ8FJOzeue+uBEET1JRA0RWlVFOuqb3o1W30SZJA6Lw==
X-Received: by 10.129.155.81 with SMTP id s78mr14948774ywg.24.1458627223094;
 Mon, 21 Mar 2016 23:13:43 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Mon, 21 Mar 2016 23:13:43 -0700 (PDT)
In-Reply-To: <CAP8UFD0tSffjJJ-kDdN6aWC6bTP3LJWjtAAFP-1s0qVH_wVx1g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289489>

On Tue, Mar 22, 2016 at 11:40 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, Mar 22, 2016 at 1:28 AM, Stefan Beller <sbeller@google.com> wrote:
>> On Mon, Mar 21, 2016 at 12:00 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> Convert the code literally without changing its design even though it
>>> seems that its obscure as to the use of comparing revision to different bisect
>>> arguments which seems like a problem in shell because of the way
>>> function arguments are handled.
>>
>> How would I use the C version instead of the shell version now?
>
> Hint: one can look at how other functions in builtin/bisect--helper.c are used.
>
>> I'd imagine you'd want to change calls in git-bisect.sh from
>>     check_term_format <term> <bad/new>
>> to be:
>>     git bisect--helper check_term_format <term> <bad/new>
>
> Hint: to get a good idea of how the call should be, one can look at
> the way "git-bisect.sh" already calls "git bisect--helper".
>
>> and "git bisect--helper" would then call the new static method?
>> Once you have the C version working (do we need additional tests
>> or can we rely on the test suite being enough for now?),
>> you can also delete the shell version.

Thanks a lot! I will dig more into this.
