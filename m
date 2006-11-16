X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH] StGIT bash completion
Date: Thu, 16 Nov 2006 16:12:43 +0000
Message-ID: <b0943d9e0611160812s6ffec19fm4bf079e08e5fce01@mail.gmail.com>
References: <20061112211813.19959.73406.stgit@localhost>
	 <b0943d9e0611160621g60a0cac2r5205e37ed7d9fe9f@mail.gmail.com>
	 <20061116154002.GA20729@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_42936_5337916.1163693563912"
NNTP-Posting-Date: Thu, 16 Nov 2006 16:14:21 +0000 (UTC)
Cc: git@vger.kernel.org, "Shawn Pearce" <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=OsvmvtPzM8sx1tIVJp+CyDPSJ2v0JkWqRgWWN4dekjPAOalL2cEQ+icwAYIsnTkskDdws3AFYLOMhe78fG9iSpkM98Zs0hqPaBlY71qLnVWgX04pavk21shVjPo8zNhC44cv6zz6qE1GviSY1+5g6sUL9/ZpFngVvmn2EjIXkDE=
In-Reply-To: <20061116154002.GA20729@diana.vm.bytemark.co.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31593>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkjr7-0008JN-08 for gcvg-git@gmane.org; Thu, 16 Nov
 2006 17:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424221AbWKPQMp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 11:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424253AbWKPQMp
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 11:12:45 -0500
Received: from nz-out-0102.google.com ([64.233.162.197]:2107 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1424221AbWKPQMo
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 11:12:44 -0500
Received: by nz-out-0102.google.com with SMTP id l1so317667nzf for
 <git@vger.kernel.org>; Thu, 16 Nov 2006 08:12:44 -0800 (PST)
Received: by 10.35.112.3 with SMTP id p3mr1049264pym.1163693564011; Thu, 16
 Nov 2006 08:12:44 -0800 (PST)
Received: by 10.35.109.8 with HTTP; Thu, 16 Nov 2006 08:12:43 -0800 (PST)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
Sender: git-owner@vger.kernel.org

------=_Part_42936_5337916.1163693563912
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 16/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2006-11-16 14:21:27 +0000, Catalin Marinas wrote:
> > Thanks for the patch. I modified it slightly to automatically
> > generate the options for other commands as well (by invoking "stg
> > help <command>" and it doesn't seem to be slow). I'll try to push it
> > tonight.
>
> Hmm. I'll have to try it, but I was half planning to hard-code the
> list of subcommands instead of calling "stg help" since it causes a
> tangible delay. On the machines I've tried, it easily takes 0.2
> seconds to run "stg help" (with hot caches; with cold caches, it's
> _really_ bad), and that's bad for interactive behavior.

Indeed, stg help takes over 200ms on my machine as well, with hot
caches but this is mainly because it imports all the stgit.commands.*
modules in order to read the short description. The 'stg help
<command>' takes around 90ms on my machine since it only imports one
module (I actually reduced it to 85ms by minimizing the imports even
further).

I could actually hard-code the commands only in the script. At the
moment I removed the _stg_* functions and added some common
_stg_all_patches() to avoid duplicating the code (see attached).

--=20
Catalin

------=_Part_42936_5337916.1163693563912
Content-Type: application/octet-stream; name="stgit-completion.bash"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="stgit-completion.bash"
X-Attachment-Id: f_euld39jh

IyBiYXNoIGNvbXBsZXRpb24gc3VwcG9ydCBmb3IgU3RHSVQgICAgICAgICAgICAgICAgICAgICAg
ICAtKi0gc2hlbGwtc2NyaXB0IC0qLQojCiMgQ29weXJpZ2h0IChDKSAyMDA2LCBLYXJsIEhhc3Nl
bHN0csO2bSA8a2hhQHRyZXNrYWwuY29tPgojIEJhc2VkIG9uIGdpdC1jb21wbGV0aW9uLnNoCiMK
IyBUbyB1c2UgdGhlc2Ugcm91dGluZXM6CiMKIyAgICAxLiBDb3B5IHRoaXMgZmlsZSB0byBzb21l
d2hlcmUgKGUuZy4gfi8uc3RnaXQtY29tcGxldGlvbi5iYXNoKS4KIwojICAgIDIuIEFkZCB0aGUg
Zm9sbG93aW5nIGxpbmUgdG8geW91ciAuYmFzaHJjOgojICAgICAgICAgLiB+Ly5zdGdpdC1jb21w
bGV0aW9uLmJhc2gKCnN0Z19jb21tYW5kcz0iCiAgICAtLWhlbHAKICAgIC0tdmVyc2lvbgogICAg
YWRkCiAgICBhcHBsaWVkCiAgICBhc3NpbWlsYXRlCiAgICBicmFuY2gKICAgIGRlbGV0ZQogICAg
ZGlmZgogICAgY2xlYW4KICAgIGNsb25lCiAgICBjb21taXQKICAgIGV4cG9ydAogICAgZmlsZXMK
ICAgIGZsb2F0CiAgICBmb2xkCiAgICBnb3RvCiAgICBoZWxwCiAgICBpZAogICAgaW1wb3J0CiAg
ICBpbml0CiAgICBsb2cKICAgIG1haWwKICAgIG5ldwogICAgcGF0Y2hlcwogICAgcGljawogICAg
cG9wCiAgICBwdWxsCiAgICBwdXNoCiAgICByZWZyZXNoCiAgICByZW5hbWUKICAgIHJlc29sdmVk
CiAgICBybQogICAgc2VyaWVzCiAgICBzaG93CiAgICBzdGF0dXMKICAgIHRvcAogICAgdW5hcHBs
aWVkCiAgICB1bmNvbW1pdAoiCgojIFRoZSBwYXRoIHRvIC5naXQsIG9yIGVtcHR5IGlmIHdlJ3Jl
IG5vdCBpbiBhIHJlcG9zaXRvcnkuCl9naXRkaXIgKCkKewogICAgZWNobyAiJChnaXQgcmV2LXBh
cnNlIC0tZ2l0LWRpciAyPi9kZXYvbnVsbCkiCn0KCiMgTmFtZSBvZiB0aGUgY3VycmVudCBicmFu
Y2gsIG9yIGVtcHR5IGlmIHRoZXJlIGlzbid0IG9uZS4KX2N1cnJlbnRfYnJhbmNoICgpCnsKICAg
IGxvY2FsIGI9JChnaXQgc3ltYm9saWMtcmVmIEhFQUQgMj4vZGV2L251bGwpCiAgICBlY2hvICR7
YiNyZWZzL2hlYWRzL30KfQoKIyBMaXN0IG9mIGFsbCBhcHBsaWVkIHBhdGNoZXMuCl9hcHBsaWVk
X3BhdGNoZXMgKCkKewogICAgbG9jYWwgZz0kKF9naXRkaXIpCiAgICBbICIkZyIgXSAmJiBjYXQg
IiRnL3BhdGNoZXMvJChfY3VycmVudF9icmFuY2gpL2FwcGxpZWQiCn0KCiMgTGlzdCBvZiBhbGwg
dW5hcHBsaWVkIHBhdGNoZXMuCl91bmFwcGxpZWRfcGF0Y2hlcyAoKQp7CiAgICBsb2NhbCBnPSQo
X2dpdGRpcikKICAgIFsgIiRnIiBdICYmIGNhdCAiJGcvcGF0Y2hlcy8kKF9jdXJyZW50X2JyYW5j
aCkvdW5hcHBsaWVkIgp9CgojIExpc3Qgb2YgYWxsIHBhdGNoZXMuCl9hbGxfcGF0Y2hlcyAoKQp7
CiAgICBsb2NhbCBiPSQoX2N1cnJlbnRfYnJhbmNoKQogICAgbG9jYWwgZz0kKF9naXRkaXIpCiAg
ICBbICIkZyIgXSAmJiBjYXQgIiRnL3BhdGNoZXMvJGIvYXBwbGllZCIgIiRnL3BhdGNoZXMvJGIv
dW5hcHBsaWVkIgp9CgojIExpc3Qgb2YgYWxsIHBhdGNoZXMgZXhjZXB0IHRoZSBjdXJyZW50IHBh
dGNoLgpfYWxsX290aGVyX3BhdGNoZXMgKCkKewogICAgbG9jYWwgYj0kKF9jdXJyZW50X2JyYW5j
aCkKICAgIGxvY2FsIGc9JChfZ2l0ZGlyKQogICAgWyAiJGciIF0gJiYgY2F0ICIkZy9wYXRjaGVz
LyRiL2FwcGxpZWQiICIkZy9wYXRjaGVzLyRiL3VuYXBwbGllZCIgXAogICAgICAgIHwgZ3JlcCAt
diAiXiQoPCAkZy9wYXRjaGVzLyRiL2N1cnJlbnQpJCIKfQoKIyBMaXN0IHRoZSBjb21tYW5kIG9w
dGlvbnMKX2NtZF9vcHRpb25zICgpCnsKICAgIHN0ZyAkMSAtLWhlbHAgfCBncmVwIC1lICIgLS1b
QS1aYS16XSIgfCBzZWQgLWUgInMvLipcKC0tW0EtWmEtel1cK1wpLiovXDEvIgp9CgojIEdlbmVy
YXRlIGNvbXBsZXRpb25zIGZvciBwYXRjaGVzIGFuZCBwYXRjaCByYW5nZXMgZnJvbSB0aGUgZ2l2
ZW4KIyBwYXRjaCBsaXN0IGZ1bmN0aW9uLCBhbmQgb3B0aW9ucyBmcm9tIHRoZSBnaXZlbiBsaXN0
LgpfY29tcGxldGVfcGF0Y2hfcmFuZ2UgKCkKewogICAgbG9jYWwgcGF0Y2hsaXN0PSIkMSIgb3B0
aW9ucz0iJDIiCiAgICBsb2NhbCBwZnggY3VyPSIke0NPTVBfV09SRFNbQ09NUF9DV09SRF19Igog
ICAgY2FzZSAiJGN1ciIgaW4KICAgICAgICAqLi4qKQogICAgICAgICAgICBwZng9IiR7Y3VyJS4u
Kn0uLiIKICAgICAgICAgICAgY3VyPSIke2N1ciMqLi59IgogICAgICAgICAgICBDT01QUkVQTFk9
KCQoY29tcGdlbiAtUCAiJHBmeCIgLVcgIiQoJHBhdGNobGlzdCkiIC0tICIkY3VyIikpCiAgICAg
ICAgICAgIDs7CiAgICAgICAgKikKICAgICAgICAgICAgQ09NUFJFUExZPSgkKGNvbXBnZW4gLVcg
IiRvcHRpb25zICQoJHBhdGNobGlzdCkiIC0tICIkY3VyIikpCiAgICAgICAgICAgIDs7CiAgICBl
c2FjCn0KCiMgR2VuZXJhdGUgY29tcGxldGlvbnMgZm9yIG9wdGlvbnMgZnJvbSB0aGUgZ2l2ZW4g
bGlzdC4KX2NvbXBsZXRlX29wdGlvbnMgKCkKewogICAgbG9jYWwgb3B0aW9ucz0iJDEiCiAgICBD
T01QUkVQTFk9KCQoY29tcGdlbiAtVyAiJG9wdGlvbnMiIC0tICIke0NPTVBfV09SRFNbQ09NUF9D
V09SRF19IikpCn0KCl9zdGdfY29tbW9uICgpCnsKICAgIF9jb21wbGV0ZV9vcHRpb25zICIkKF9j
bWRfb3B0aW9ucyAkMSkiCn0KCl9zdGdfYWxsX3BhdGNoZXMgKCkKewogICAgX2NvbXBsZXRlX3Bh
dGNoX3JhbmdlIF9hbGxfcGF0Y2hlcyAiJChfY21kX29wdGlvbnMgJDEpIgp9Cgpfc3RnX290aGVy
X3BhdGNoZXMgKCkKewogICAgX2NvbXBsZXRlX3BhdGNoX3JhbmdlIF9hbGxfb3RoZXJfcGF0Y2hl
cyAiJChfY21kX29wdGlvbnMgJDEpIgp9Cgpfc3RnX2FwcGxpZWRfcGF0Y2hlcyAoKQp7CiAgICBf
Y29tcGxldGVfcGF0Y2hfcmFuZ2UgX2FwcGxpZWRfcGF0Y2hlcyAiJChfY21kX29wdGlvbnMgJDEp
Igp9Cgpfc3RnX3VuYXBwbGllZF9wYXRjaGVzICgpCnsKICAgIF9jb21wbGV0ZV9wYXRjaF9yYW5n
ZSBfdW5hcHBsaWVkX3BhdGNoZXMgIiQoX2NtZF9vcHRpb25zICQxKSIKfQoKX3N0ZyAoKQp7CiAg
ICBsb2NhbCBpIGM9MSBjb21tYW5kCgogICAgd2hpbGUgWyAkYyAtbHQgJENPTVBfQ1dPUkQgXTsg
ZG8KICAgICAgICBpZiBbICRjID09IDEgXTsgdGhlbgogICAgICAgICAgICBjb21tYW5kPSIke0NP
TVBfV09SRFNbY119IgogICAgICAgIGZpCiAgICAgICAgYz0kKCgrK2MpKQogICAgZG9uZQoKICAg
ICMgQ29tcGxldGUgbmFtZSBvZiBzdWJjb21tYW5kLgogICAgaWYgWyAkYyAtZXEgJENPTVBfQ1dP
UkQgLWEgLXogIiRjb21tYW5kIiBdOyB0aGVuCiAgICAgICAgQ09NUFJFUExZPSgkKGNvbXBnZW4g
XAogICAgICAgICAgICAtVyAiJHN0Z19jb21tYW5kcyIgXAogICAgICAgICAgICAtLSAiJHtDT01Q
X1dPUkRTW0NPTVBfQ1dPUkRdfSIpKQogICAgICAgIHJldHVybjsKICAgIGZpCgogICAgIyBDb21w
bGV0ZSBhcmd1bWVudHMgdG8gc3ViY29tbWFuZHMuCiAgICBjYXNlICIkY29tbWFuZCIgaW4KICAg
ICAgICAjIHJlcG9zaXRvcnkgY29tbWFuZHMKICAgICAgICBpZCkgICAgIF9zdGdfYWxsX3BhdGNo
ZXMgJGNvbW1hbmQgOzsKICAgICAgICAjIHN0YWNrIGNvbW1hbmRzCiAgICAgICAgZmxvYXQpICBf
c3RnX2FsbF9wYXRjaGVzICRjb21tYW5kIDs7CiAgICAgICAgZ290bykgICBfc3RnX290aGVyX3Bh
dGNoZXMgJGNvbW1hbmQgOzsKICAgICAgICBwb3ApICAgIF9zdGdfYXBwbGllZF9wYXRjaGVzICRj
b21tYW5kIDs7CiAgICAgICAgcHVzaCkgICBfc3RnX3VuYXBwbGllZF9wYXRjaGVzICRjb21tYW5k
IDs7CiAgICAgICAgIyBwYXRjaCBjb21tYW5kcwogICAgICAgIGRlbGV0ZSkgX3N0Z19hbGxfcGF0
Y2hlcyAkY29tbWFuZCA7OwogICAgICAgIGV4cG9ydCkgX3N0Z19hcHBsaWVkX3BhdGNoZXMgJGNv
bW1hbmQgOzsKICAgICAgICBmaWxlcykgIF9zdGdfYWxsX3BhdGNoZXMgJGNvbW1hbmQgOzsKICAg
ICAgICBsb2cpICAgIF9zdGdfYWxsX3BhdGNoZXMgJGNvbW1hbmQgOzsKICAgICAgICBtYWlsKSAg
IF9zdGdfYXBwbGllZF9wYXRjaGVzICRjb21tYW5kIDs7CiAgICAgICAgcGljaykgICBfc3RnX3Vu
YXBwbGllZF9wYXRjaGVzICRjb21tYW5kIDs7CiAgICAgICAgcmVuYW1lKSBfc3RnX2FsbF9wYXRj
aGVzICRjb21tYW5kIDs7CiAgICAgICAgc2hvdykgICBfc3RnX2FsbF9wYXRjaGVzICRjb21tYW5k
IDs7CiAgICAgICAgIyBhbGwgdGhlIG90aGVyIGNvbW1hbmRzCiAgICAgICAgKikgICAgICBfc3Rn
X2NvbW1vbiAkY29tbWFuZCA7OwogICAgZXNhYwp9Cgpjb21wbGV0ZSAtbyBkZWZhdWx0IC1GIF9z
dGcgc3RnCg==
