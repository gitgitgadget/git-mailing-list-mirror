From: Pat Thoyts <patthoyts@gmail.com>
Subject: Re: [PATCH] git tag --contains : avoid stack overflow
Date: Sat, 10 Nov 2012 21:33:24 +0000
Message-ID: <CABNJ2G+hnCgs9u64c83s+2fnVyp584e4PPX7F6BF34T1ieDrhA@mail.gmail.com>
References: <1352568970-4669-1-git-send-email-jeanjacques.lafay@gmail.com>
	<03ED9D50D1F64467863C051959CFC433@PhilipOakley>
	<d9843c09-3ca9-406e-9df8-78603235d985@googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: msysgit@googlegroups.com, Git List <git@vger.kernel.org>, 
	Philip Oakley <philipoakley@iee.org>
To: Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
X-From: msysgit+bncBDRPLLPZ44IBBJEQ7OCAKGQEOECJVVA@googlegroups.com Sat Nov 10 22:33:36 2012
Return-path: <msysgit+bncBDRPLLPZ44IBBJEQ7OCAKGQEOECJVVA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gh0-f186.google.com ([209.85.160.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDRPLLPZ44IBBJEQ7OCAKGQEOECJVVA@googlegroups.com>)
	id 1TXIgJ-00014n-CD
	for gcvm-msysgit@m.gmane.org; Sat, 10 Nov 2012 22:33:35 +0100
Received: by mail-gh0-f186.google.com with SMTP id f18sf3867344ghb.3
        for <gcvm-msysgit@m.gmane.org>; Sat, 10 Nov 2012 13:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=21S8OUfIvJqmpgXIIFJhCoPOPXhs7rA+h+hskFwbxdA=;
        b=mb17FHNMuDn17Qu7F6Jh8rY7spd1qStwjEoYDWrNBMmzSNJrT3faDrF3Ng1VCf2tfO
         23S+w1XTw3e+7wrXjhAEl6+mAAlGmb5jO/k4FHGfk0eADaWRSMDMnP/hekekpGuD3aqH
         LFPbAQhvfTuA50i5BZKbYFDWq71voL1GbWp2Y5yEdf59G/Uq6ReyXTvaFyYQCzOoFohP
         geYqX5nr++xwV4bVyNVFSiWd/XwCsYHiYdhCCg9RKIE8fG+m8l28JRaMhpiO1SQcNPFJ
         A2UG1N6bpTM2iP2JfkzKqqWOEQlqfNbfBmm4VWftiXivL8ff5WllhxpOwJI 
Received: by 10.68.243.137 with SMTP id wy9mr2960639pbc.0.1352583205212;
        Sat, 10 Nov 2012 13:33:25 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.68.254.169 with SMTP id aj9ls20067464pbd.0.gmail; Sat, 10 Nov
 2012 13:33:24 -0800 (PST)
Received: by 10.66.75.39 with SMTP id z7mr6513886pav.26.1352583204794;
        Sat, 10 Nov 2012 13:33:24 -0800 (PST)
Received: by 10.66.75.39 with SMTP id z7mr6513884pav.26.1352583204783;
        Sat, 10 Nov 2012 13:33:24 -0800 (PST)
Received: from mail-da0-f49.google.com (mail-da0-f49.google.com [209.85.210.49])
        by gmr-mx.google.com with ESMTPS id r4si500086paz.1.2012.11.10.13.33.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 10 Nov 2012 13:33:24 -0800 (PST)
Received-SPF: pass (google.com: domain of patthoyts@gmail.com designates 209.85.210.49 as permitted sender) client-ip=209.85.210.49;
Received: by mail-da0-f49.google.com with SMTP id q27so2222636daj.8
        for <msysgit@googlegroups.com>; Sat, 10 Nov 2012 13:33:24 -0800 (PST)
Received: by 10.68.238.199 with SMTP id vm7mr44591331pbc.105.1352583204648;
 Sat, 10 Nov 2012 13:33:24 -0800 (PST)
Received: by 10.66.232.196 with HTTP; Sat, 10 Nov 2012 13:33:24 -0800 (PST)
In-Reply-To: <d9843c09-3ca9-406e-9df8-78603235d985@googlegroups.com>
X-Original-Sender: patthoyts@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of patthoyts@gmail.com designates 209.85.210.49 as permitted sender)
 smtp.mail=patthoyts@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209308>

On 10 November 2012 21:13, Jean-Jacques Lafay
<jeanjacques.lafay@gmail.com> wrote:
> Le samedi 10 novembre 2012 21:00:10 UTC+1, Philip Oakley a =E9crit :
>>
>> From: "Jean-Jacques Lafay" <jeanjacq...@gmail.com> Sent: Saturday,
>> November 10, 2012 5:36 PM
>> > In large repos, the recursion implementation of contains(commit,
>> > commit_list)
>> > may result in a stack overflow. Replace the recursion with a loop to
>> > fix it.
>> >
>> > Signed-off-by: Jean-Jacques Lafay <jeanjacq...@gmail.com>
>>
>> This is a change to the main git code so it is better to submit it to
>> the main git list at g...@vger.kernel.org (plain text, no HTML, first
>> post usually has a delay ;-)
>>
>> It sounds reasonable but others may have opinions and comments.
>>
>> Have you actually suffered from the stack overflow issue? You only
>> suggest it as a possibility, rather than a real problem.
>>
>> Philip
>
>
> Yes, it actually crashed on me, and since the call is made by GitExtensio=
n
> while browsing the commit history, it was quickly annoying to have window=
s
> popping a "git.exe stopped working" message box at my face every time I
> clicked on a line of the history ;-)  (well, you can sort of work around =
it
> by having the "file tree" or "diff" tab active)
>
> Coincidentally, as I was having a glance at the recent topics, I saw that
> someone else experienced it.
>
> However, I couldn't reproduce it on Linux : where the windows
> implementations crashes at a ~32000 depth (*not* exactly 32768, mind you)=
,
> on linux it happily went through 100000 commits. I didn't take time to lo=
ok
> much further, but maybe on my 64 bit Linux VM, the process can afford to
> reserve a much bigger address range for the stack of each thread than the
> 1Mb given to 32 bit processes on windows.
>
> Jean-Jacques.

I checked this on msysGit - the test causes a crash on Windows when
using the 1.8.0 release and recompiling with this patch applied fixes
this. As mentioned, its best to have this reviewed upstream too as its
likely that windows just has a smaller stack so causes the crash
earlier.

--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den
