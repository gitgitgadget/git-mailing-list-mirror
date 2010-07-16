From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH] Update compat/regex
Date: Fri, 16 Jul 2010 13:58:03 +0000
Message-ID: <AANLkTimQZDT3PuiLDdjPXzWlLiEI5Iv1zy5iFPlRswyC@mail.gmail.com>
References: <1278549735-19278-1-git-send-email-avarab@gmail.com>
	<7viq4ppxt9.fsf@alter.siamese.dyndns.org>
	<AANLkTikuGY4LVrCB6UoGFhxthoI8MgvAXCwCbiXhwq_d@mail.gmail.com>
	<7vtyo0vdpz.fsf@alter.siamese.dyndns.org>
	<AANLkTim-4I5Sdu653yJOmnVYDqI8bb71839Vqfd3FKCi@mail.gmail.com>
	<20100715220059.GA3312@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 16 15:58:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZlQm-0005cV-MW
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 15:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965639Ab0GPN6H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jul 2010 09:58:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60921 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965621Ab0GPN6E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jul 2010 09:58:04 -0400
Received: by iwn7 with SMTP id 7so2166700iwn.19
        for <git@vger.kernel.org>; Fri, 16 Jul 2010 06:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4S9nBSOaf8iylxt3t1ByEDLGw3b8BxGAyx4kcXhuZsg=;
        b=Iq/L0kvLXVLqXfrTMgsGRxWztxgGvI226ER1mwuzC9ETQU3PrLBXziicaMvN7xp28v
         rlfw8jy5n4yOcQcuKmlI7hvhuVnTqhcx/WwDimfW4jt+Q6gAOi4jg75NvMn72Eza2h+q
         xAA9RvSWKlLpPV54JTjyIBrUuRHkbT4n6KgpY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aiFk4eNcTiBJUBiT3+Qamwf6cZykw95Kja4GWRtakeEMEw50tL/bw9NBJwzYF7PyzA
         yimFm5PYM61Xq2+HeApLC473jjm1cSCvxDj8jYt+0/gG3z9uu1Oo01L/fyAcibyURNfO
         5fk8iVUxSMInx5fefkutMIt94Xm12TRp9FiyM=
Received: by 10.231.173.145 with SMTP id p17mr1016220ibz.32.1279288683441; 
	Fri, 16 Jul 2010 06:58:03 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Fri, 16 Jul 2010 06:58:03 -0700 (PDT)
In-Reply-To: <20100715220059.GA3312@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151150>

On Thu, Jul 15, 2010 at 22:00, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> The old glibc regular expression library git uses does not support
> REG_STARTEND. Borrow the latest version from the GNU C library
> (version 2.12, license is LGPL 2.1 or later).
>
> Changes from glibc version: update the FSF address in the license
> header, use _LIBC_REGEX macro to allow building outside of glibc,
> add MAX, bool, true, and false macros to allow building with a C89
> compiler.
>
> Reintroduces warnings that were fixed in git before. =C2=A0They can b=
e
> defeated again separately. =C2=A0Nevertheless this should be an
> improvement.

Those should be funneled upstream anyway, not just fixed in our tree.

> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason wrote:
>
>> Unfortunately that seems
>> easier said than done, since the library is now part of glibc, and h=
as
>> aquired a lot of glibc specific macros and other constructs
>
> Oh, come on. :)
>
> Completely untested.

This patch has all the glibc-specific stuff that makes it break hard
if you don't have the GNU C library. Writing macros/definitions to fix =
all that
stuff up was the "easier said than done" part I was referring to.

It's probably not that hard (although I wouldn't put it past GNU to
have e.g. GCC-specific stuff in the code, but I haven't checked), just
tedious.

on Solaris:

    In file included from compat/regex/regex.c:73:
    compat/regex/regex_internal.c:40: error: syntax error before
"re_string_allocate"
    compat/regex/regex_internal.c:42: warning: return type defaults to =
`int'
    compat/regex/regex_internal.c:68: error: syntax error before
"re_string_construct"
    compat/regex/regex_internal.c:70: warning: return type defaults to =
`int'
    compat/regex/regex_internal.c:131: error: syntax error before
"re_string_realloc_buffers"
    compat/regex/regex_internal.c:132: warning: return type defaults to=
 `int'
    compat/regex/regex_internal.c:132: error: conflicting types for
're_string_realloc_buffers'
    compat/regex/regex_internal.h:392: error: previous declaration of
're_string_realloc_buffers' was here
    compat/regex/regex_internal.c:132: error: conflicting types for
're_string_realloc_buffers'
    compat/regex/regex_internal.h:392: error: previous declaration of
're_string_realloc_buffers' was here
    compat/regex/regex_internal.c:572: error: syntax error before
"re_string_reconstruct"
    compat/regex/regex_internal.c:573: warning: return type defaults to=
 `int'
    compat/regex/regex_internal.c: In function `re_string_reconstruct':
    compat/regex/regex_internal.c:687: warning: unused variable `prev_v=
alid_len'
    compat/regex/regex_internal.c: At top level:
    compat/regex/regex_internal.c:962: error: syntax error before
"re_node_set_alloc"
    compat/regex/regex_internal.c:963: warning: return type defaults to=
 `int'
    compat/regex/regex_internal.c:974: error: syntax error before
"re_node_set_init_1"
    compat/regex/regex_internal.c:975: warning: return type defaults to=
 `int'
    compat/regex/regex_internal.c:990: error: syntax error before
"re_node_set_init_2"
    compat/regex/regex_internal.c:991: warning: return type defaults to=
 `int'
    compat/regex/regex_internal.c:1020: error: syntax error before
"re_node_set_init_copy"
    compat/regex/regex_internal.c:1021: warning: return type defaults t=
o `int'
    compat/regex/regex_internal.c:1045: error: syntax error before
"re_node_set_add_intersect"
    compat/regex/regex_internal.c:1047: warning: return type defaults t=
o `int'
    compat/regex/regex_internal.c:1136: error: syntax error before
"re_node_set_init_union"
    compat/regex/regex_internal.c:1138: warning: return type defaults t=
o `int'
    compat/regex/regex_internal.c:1189: error: syntax error before
"re_node_set_merge"
    compat/regex/regex_internal.c:1190: warning: return type defaults t=
o `int'
    compat/regex/regex_internal.c:1272: error: syntax error before
"re_node_set_insert"
    compat/regex/regex_internal.c:1273: warning: return type defaults t=
o `int'
    compat/regex/regex_internal.c:1329: error: syntax error before
"re_node_set_insert_last"
    compat/regex/regex_internal.c:1330: warning: return type defaults t=
o `int'
    compat/regex/regex_internal.c: In function `re_dfa_add_node':
    compat/regex/regex_internal.c:1406: warning: unused variable `type'
    compat/regex/regex_internal.c: At top level:
    compat/regex/regex_internal.c:1472: error: syntax error before
"re_acquire_state"
    compat/regex/regex_internal.c:1474: warning: return type defaults t=
o `int'
    compat/regex/regex_internal.c: In function `re_acquire_state':
    compat/regex/regex_internal.c:1493: warning: return makes integer
from pointer without a cast
    compat/regex/regex_internal.c:1501: warning: return makes integer
from pointer without a cast
    compat/regex/regex_internal.c: At top level:
    compat/regex/regex_internal.c:1516: error: syntax error before
"re_acquire_state_context"
    compat/regex/regex_internal.c:1518: warning: return type defaults t=
o `int'
    compat/regex/regex_internal.c: In function `re_acquire_state_contex=
t':
    compat/regex/regex_internal.c:1537: warning: return makes integer
from pointer without a cast
    compat/regex/regex_internal.c:1544: warning: return makes integer
from pointer without a cast
    compat/regex/regex_internal.c: At top level:
    compat/regex/regex_internal.c:1553: error: syntax error before
"register_state"
    compat/regex/regex_internal.c:1555: warning: return type defaults t=
o `int'
    compat/regex/regex_internal.c:1608: error: syntax error before
"create_ci_newstate"
    compat/regex/regex_internal.c:1610: warning: return type defaults t=
o `int'
    compat/regex/regex_internal.c:1610: error: conflicting types for
'create_ci_newstate'
    compat/regex/regex_internal.c:27: error: previous declaration of
'create_ci_newstate' was here
    compat/regex/regex_internal.c:1610: error: conflicting types for
'create_ci_newstate'
    compat/regex/regex_internal.c:27: error: previous declaration of
'create_ci_newstate' was here
    compat/regex/regex_internal.c: In function `create_ci_newstate':
    compat/regex/regex_internal.c:1650: warning: return makes integer
from pointer without a cast
    compat/regex/regex_internal.c: At top level:
    compat/regex/regex_internal.c:1658: error: syntax error before
"create_cd_newstate"
    compat/regex/regex_internal.c:1660: warning: return type defaults t=
o `int'
    compat/regex/regex_internal.c:1660: error: conflicting types for
'create_cd_newstate'
    compat/regex/regex_internal.c:31: error: previous declaration of
'create_cd_newstate' was here
    compat/regex/regex_internal.c:1660: error: conflicting types for
'create_cd_newstate'
    compat/regex/regex_internal.c:31: error: previous declaration of
'create_cd_newstate' was here
    compat/regex/regex_internal.c: In function `create_cd_newstate':
    compat/regex/regex_internal.c:1726: warning: return makes integer
from pointer without a cast
    In file included from compat/regex/regex.c:74:
    compat/regex/regcomp.c: In function `create_initial_state':
    compat/regex/regcomp.c:1013: warning: assignment makes pointer
from integer without a cast
    compat/regex/regcomp.c:1020: warning: assignment makes pointer
from integer without a cast
    compat/regex/regcomp.c:1022: warning: assignment makes pointer
from integer without a cast
    compat/regex/regcomp.c:1026: warning: assignment makes pointer
from integer without a cast
    In file included from compat/regex/regex.c:75:
    compat/regex/regexec.c: In function `regexec':
    compat/regex/regexec.c:230: warning: unused variable `dfa'
    compat/regex/regexec.c: In function `re_search_stub':
    compat/regex/regexec.c:418: warning: unused variable `dfa'
    compat/regex/regexec.c: At top level:
    compat/regex/regexec.c:629: error: syntax error before "re_search_i=
nternal"
    compat/regex/regexec.c:631: warning: return type defaults to `int'
    compat/regex/regexec.c:631: error: conflicting types for
're_search_internal'
    compat/regex/regexec.c:43: error: previous declaration of
're_search_internal' was here
    compat/regex/regexec.c:631: error: conflicting types for
're_search_internal'
    compat/regex/regexec.c:43: error: previous declaration of
're_search_internal' was here
    compat/regex/regexec.c:956: error: syntax error before
"prune_impossible_nodes"
    compat/regex/regexec.c:957: warning: return type defaults to `int'
    compat/regex/regexec.c:957: error: conflicting types for
'prune_impossible_nodes'
    compat/regex/regexec.c:56: error: previous declaration of
'prune_impossible_nodes' was here
    compat/regex/regexec.c:957: error: conflicting types for
'prune_impossible_nodes'
    compat/regex/regexec.c:56: error: previous declaration of
'prune_impossible_nodes' was here
    compat/regex/regexec.c: In function `acquire_init_state_context':
    compat/regex/regexec.c:1074: warning: return makes pointer from
integer without a cast
    compat/regex/regexec.c: At top level:
    compat/regex/regexec.c:1095: error: syntax error before "check_matc=
hing"
    compat/regex/regexec.c:1097: warning: return type defaults to `int'
    compat/regex/regexec.c:1097: error: conflicting types for 'check_ma=
tching'
    compat/regex/regexec.c:58: error: previous declaration of
'check_matching' was here
    compat/regex/regexec.c:1097: error: conflicting types for 'check_ma=
tching'
    compat/regex/regexec.c:58: error: previous declaration of
'check_matching' was here
    compat/regex/regexec.c:1368: error: syntax error before "push_fail_=
stack"
    compat/regex/regexec.c:1370: warning: return type defaults to `int'
    compat/regex/regexec.c:1370: error: conflicting types for 'push_fai=
l_stack'
    compat/regex/regexec.c:69: error: previous declaration of
'push_fail_stack' was here
    compat/regex/regexec.c:1370: error: conflicting types for 'push_fai=
l_stack'
    compat/regex/regexec.c:69: error: previous declaration of
'push_fail_stack' was here
    compat/regex/regexec.c:1415: error: syntax error before "set_regs"
    compat/regex/regexec.c:1417: warning: return type defaults to `int'
    compat/regex/regexec.c:1417: error: conflicting types for 'set_regs=
'
    compat/regex/regexec.c:73: error: previous declaration of
'set_regs' was here
    compat/regex/regexec.c:1417: error: conflicting types for 'set_regs=
'
    compat/regex/regexec.c:73: error: previous declaration of
'set_regs' was here
    compat/regex/regexec.c:1669: error: syntax error before
"build_sifted_states"
    compat/regex/regexec.c:1671: warning: return type defaults to `int'
    compat/regex/regexec.c:1671: error: conflicting types for
'build_sifted_states'
    compat/regex/regexec.c:89: error: previous declaration of
'build_sifted_states' was here
    compat/regex/regexec.c:1671: error: conflicting types for
'build_sifted_states'
    compat/regex/regexec.c:89: error: previous declaration of
'build_sifted_states' was here
    compat/regex/regexec.c: In function `merge_state_array':
    compat/regex/regexec.c:1772: warning: assignment makes pointer
from integer without a cast
    compat/regex/regexec.c: In function `update_cur_sifted_state':
    compat/regex/regexec.c:1815: warning: assignment makes pointer
from integer without a cast
    compat/regex/regexec.c: At top level:
    compat/regex/regexec.c:1831: error: syntax error before
"add_epsilon_src_nodes"
    compat/regex/regexec.c:1833: warning: return type defaults to `int'
    compat/regex/regexec.c:1833: error: conflicting types for
'add_epsilon_src_nodes'
    compat/regex/regexec.c:98: error: previous declaration of
'add_epsilon_src_nodes' was here
    compat/regex/regexec.c:1833: error: conflicting types for
'add_epsilon_src_nodes'
    compat/regex/regexec.c:98: error: previous declaration of
'add_epsilon_src_nodes' was here
    compat/regex/regexec.c: In function `add_epsilon_src_nodes':
    compat/regex/regexec.c:1837: warning: initialization makes pointer
from integer without a cast
    compat/regex/regexec.c: At top level:
    compat/regex/regexec.c:2144: error: syntax error before "sift_state=
s_bkref"
    compat/regex/regexec.c:2146: warning: return type defaults to `int'
    compat/regex/regexec.c:2146: error: conflicting types for
'sift_states_bkref'
    compat/regex/regexec.c:120: error: previous declaration of
'sift_states_bkref' was here
    compat/regex/regexec.c:2146: error: conflicting types for
'sift_states_bkref'
    compat/regex/regexec.c:120: error: previous declaration of
'sift_states_bkref' was here
    compat/regex/regexec.c:2274: error: syntax error before "transit_st=
ate"
    compat/regex/regexec.c:2276: warning: return type defaults to `int'
    compat/regex/regexec.c:2276: error: conflicting types for 'transit_=
state'
    compat/regex/regexec.c:129: error: previous declaration of
'transit_state' was here
    compat/regex/regexec.c:2276: error: conflicting types for 'transit_=
state'
    compat/regex/regexec.c:129: error: previous declaration of
'transit_state' was here
    compat/regex/regexec.c: In function `transit_state':
    compat/regex/regexec.c:2303: warning: return makes integer from
pointer without a cast
    compat/regex/regexec.c:2314: warning: return makes integer from
pointer without a cast
    compat/regex/regexec.c:2316: warning: return makes integer from
pointer without a cast
    compat/regex/regexec.c: In function `merge_state_with_log':
    compat/regex/regexec.c:2375: warning: assignment makes pointer
from integer without a cast
    compat/regex/regexec.c: In function `transit_state_bkref':
    compat/regex/regexec.c:2648: warning: assignment makes pointer
from integer without a cast
    compat/regex/regexec.c:2665: warning: assignment makes pointer
from integer without a cast
    compat/regex/regexec.c: At top level:
    compat/regex/regexec.c:2699: error: syntax error before "get_subexp=
"
    compat/regex/regexec.c:2700: warning: return type defaults to `int'
    compat/regex/regexec.c:2700: error: conflicting types for 'get_sube=
xp'
    compat/regex/regexec.c:153: error: previous declaration of
'get_subexp' was here
    compat/regex/regexec.c:2700: error: conflicting types for 'get_sube=
xp'
    compat/regex/regexec.c:153: error: previous declaration of
'get_subexp' was here
    compat/regex/regexec.c:2899: error: syntax error before "check_arri=
val"
    compat/regex/regexec.c:2901: warning: return type defaults to `int'
    compat/regex/regexec.c:2901: error: conflicting types for 'check_ar=
rival'
    compat/regex/regexec.c:164: error: previous declaration of
'check_arrival' was here
    compat/regex/regexec.c:2901: error: conflicting types for 'check_ar=
rival'
    compat/regex/regexec.c:164: error: previous declaration of
'check_arrival' was here
    compat/regex/regexec.c: In function `check_arrival':
    compat/regex/regexec.c:2974: warning: assignment makes pointer
from integer without a cast
    compat/regex/regexec.c:3025: warning: assignment makes pointer
from integer without a cast
    compat/regex/regexec.c: At top level:
    compat/regex/regexec.c:3060: error: syntax error before
"check_arrival_add_next_nodes"
    compat/regex/regexec.c:3062: warning: return type defaults to `int'
    compat/regex/regexec.c:3062: error: conflicting types for
'check_arrival_add_next_nodes'
    compat/regex/regexec.c:169: error: previous declaration of
'check_arrival_add_next_nodes' was here
    compat/regex/regexec.c:3062: error: conflicting types for
'check_arrival_add_next_nodes'
    compat/regex/regexec.c:169: error: previous declaration of
'check_arrival_add_next_nodes' was here
    compat/regex/regexec.c: In function `check_arrival_add_next_nodes':
    compat/regex/regexec.c:3066: warning: unused variable `err'
    compat/regex/regexec.c: At top level:
    compat/regex/regexec.c:3192: error: syntax error before
"check_arrival_expand_ecl_sub"
    compat/regex/regexec.c:3194: warning: return type defaults to `int'
    compat/regex/regexec.c:3194: error: conflicting types for
'check_arrival_expand_ecl_sub'
    compat/regex/regexec.c:177: error: previous declaration of
'check_arrival_expand_ecl_sub' was here
    compat/regex/regexec.c:3194: error: conflicting types for
'check_arrival_expand_ecl_sub'
    compat/regex/regexec.c:177: error: previous declaration of
'check_arrival_expand_ecl_sub' was here
    compat/regex/regexec.c:3236: error: syntax error before "expand_bkr=
ef_cache"
    compat/regex/regexec.c:3238: warning: return type defaults to `int'
    compat/regex/regexec.c:3238: error: conflicting types for
'expand_bkref_cache'
    compat/regex/regexec.c:181: error: previous declaration of
'expand_bkref_cache' was here
    compat/regex/regexec.c:3238: error: conflicting types for
'expand_bkref_cache'
    compat/regex/regexec.c:181: error: previous declaration of
'expand_bkref_cache' was here
    compat/regex/regexec.c: In function `expand_bkref_cache':
    compat/regex/regexec.c:3309: warning: assignment makes pointer
from integer without a cast
    compat/regex/regexec.c: In function `build_trtable':
    compat/regex/regexec.c:3434: warning: assignment makes pointer
from integer without a cast
    compat/regex/regexec.c:3442: warning: assignment makes pointer
from integer without a cast
    compat/regex/regexec.c:3450: warning: assignment makes pointer
from integer without a cast
    compat/regex/regexec.c: At top level:
    compat/regex/regexec.c:4102: error: syntax error before "extend_buf=
fers"
    compat/regex/regexec.c:4103: warning: return type defaults to `int'
    compat/regex/regexec.c:4103: error: conflicting types for 'extend_b=
uffers'
    compat/regex/regexec.c:202: error: previous declaration of
'extend_buffers' was here
    compat/regex/regexec.c:4103: error: conflicting types for 'extend_b=
uffers'
    compat/regex/regexec.c:202: error: previous declaration of
'extend_buffers' was here
    compat/regex/regexec.c:4165: error: syntax error before "match_ctx_=
init"
    compat/regex/regexec.c:4166: warning: return type defaults to `int'
    compat/regex/regexec.c:4166: error: conflicting types for 'match_ct=
x_init'
    compat/regex/regexec.c:22: error: previous declaration of
'match_ctx_init' was here
    compat/regex/regexec.c:4166: error: conflicting types for 'match_ct=
x_init'
    compat/regex/regexec.c:22: error: previous declaration of
'match_ctx_init' was here
    compat/regex/regexec.c:4238: error: syntax error before
"match_ctx_add_entry"
    compat/regex/regexec.c:4240: warning: return type defaults to `int'
    compat/regex/regexec.c:4240: error: conflicting types for
'match_ctx_add_entry'
    compat/regex/regexec.c:27: error: previous declaration of
'match_ctx_add_entry' was here
    compat/regex/regexec.c:4240: error: conflicting types for
'match_ctx_add_entry'
    compat/regex/regexec.c:27: error: previous declaration of
'match_ctx_add_entry' was here
    compat/regex/regexec.c:4310: error: syntax error before
"match_ctx_add_subtop"
    compat/regex/regexec.c:4311: warning: return type defaults to `int'
    compat/regex/regexec.c:4311: error: conflicting types for
'match_ctx_add_subtop'
    compat/regex/regexec.c:31: error: previous declaration of
'match_ctx_add_subtop' was here
    compat/regex/regexec.c:4311: error: conflicting types for
'match_ctx_add_subtop'
    compat/regex/regexec.c:31: error: previous declaration of
'match_ctx_add_subtop' was here
    compat/regex/regex_internal.h:392: warning:
're_string_realloc_buffers' declared `static' but never defined
    compat/regex/regex_internal.c:27: warning: 'create_ci_newstate'
declared `static' but never defined
    compat/regex/regex_internal.c:31: warning: 'create_cd_newstate'
declared `static' but never defined
    compat/regex/regexec.c:22: warning: 'match_ctx_init' declared
`static' but never defined
    compat/regex/regexec.c:27: warning: 'match_ctx_add_entry' declared
`static' but never defined
    compat/regex/regexec.c:31: warning: 'match_ctx_add_subtop'
declared `static' but never defined
    compat/regex/regexec.c:43: warning: 're_search_internal' declared
`static' but never defined
    compat/regex/regexec.c:56: warning: 'prune_impossible_nodes'
declared `static' but never defined
    compat/regex/regexec.c:58: warning: 'check_matching' declared
`static' but never defined
    compat/regex/regexec.c:69: warning: 'push_fail_stack' declared
`static' but never defined
    compat/regex/regexec.c:73: warning: 'set_regs' declared `static'
but never defined
    compat/regex/regexec.c:89: warning: 'build_sifted_states' declared
`static' but never defined
    compat/regex/regexec.c:98: warning: 'add_epsilon_src_nodes'
declared `static' but never defined
    compat/regex/regexec.c:120: warning: 'sift_states_bkref' declared
`static' but never defined
    compat/regex/regexec.c:129: warning: 'transit_state' declared
`static' but never defined
    compat/regex/regexec.c:153: warning: 'get_subexp' declared
`static' but never defined
    compat/regex/regexec.c:164: warning: 'check_arrival' declared
`static' but never defined
    compat/regex/regexec.c:169: warning:
'check_arrival_add_next_nodes' declared `static' but never defined
    compat/regex/regexec.c:177: warning:
'check_arrival_expand_ecl_sub' declared `static' but never defined
    compat/regex/regexec.c:181: warning: 'expand_bkref_cache' declared
`static' but never defined
    compat/regex/regexec.c:202: warning: 'extend_buffers' declared
`static' but never defined
    gmake: *** [compat/regex/regex.o] Error 1

And on FreeBSD:

    In file included from git-compat-util.h:93,
                     from cache.h:4,
                     from thread-utils.c:1:
    compat/regex/regex.h:367: warning: declaration does not declare any=
thing
        CC compat/memmem.o
    In file included from compat/../git-compat-util.h:93,
                     from compat/memmem.c:1:
    compat/regex/regex.h:367: warning: declaration does not declare any=
thing
        CC compat/regex/regex.o
    In file included from compat/regex/regex.c:63:
    compat/regex/regex_internal.h:421:20: error: alloca.h: No such
file or directory
    In file included from compat/regex/regex.c:73:
    compat/regex/regex_internal.c:40: error: expected '=3D', ',', ';',
'asm' or '__attribute__' before 're_string_allocate'
    compat/regex/regex_internal.c:68: error: expected '=3D', ',', ';',
'asm' or '__attribute__' before 're_string_construct'
    compat/regex/regex_internal.c:131: error: expected '=3D', ',', ';',
'asm' or '__attribute__' before 're_string_realloc_buffers'
    compat/regex/regex_internal.c:572: error: expected '=3D', ',', ';',
'asm' or '__attribute__' before 're_string_reconstruct'
    compat/regex/regex_internal.c:962: error: expected '=3D', ',', ';',
'asm' or '__attribute__' before 're_node_set_alloc'
    compat/regex/regex_internal.c:974: error: expected '=3D', ',', ';',
'asm' or '__attribute__' before 're_node_set_init_1'
    compat/regex/regex_internal.c:990: error: expected '=3D', ',', ';',
'asm' or '__attribute__' before 're_node_set_init_2'
    compat/regex/regex_internal.c:1020: error: expected '=3D', ',', ';'=
,
'asm' or '__attribute__' before 're_node_set_init_copy'
    compat/regex/regex_internal.c:1045: error: expected '=3D', ',', ';'=
,
'asm' or '__attribute__' before 're_node_set_add_intersect'
    compat/regex/regex_internal.c:1136: error: expected '=3D', ',', ';'=
,
'asm' or '__attribute__' before 're_node_set_init_union'
    compat/regex/regex_internal.c:1189: error: expected '=3D', ',', ';'=
,
'asm' or '__attribute__' before 're_node_set_merge'
    compat/regex/regex_internal.c:1272: error: expected '=3D', ',', ';'=
,
'asm' or '__attribute__' before 're_node_set_insert'
    compat/regex/regex_internal.c:1329: error: expected '=3D', ',', ';'=
,
'asm' or '__attribute__' before 're_node_set_insert_last'
    compat/regex/regex_internal.c: In function 're_dfa_add_node':
    compat/regex/regex_internal.c:1406: warning: unused variable 'type'
    compat/regex/regex_internal.c: At top level:
    compat/regex/regex_internal.c:1472: error: expected '=3D', ',', ';'=
,
'asm' or '__attribute__' before 're_acquire_state'
    compat/regex/regex_internal.c:1516: error: expected '=3D', ',', ';'=
,
'asm' or '__attribute__' before 're_acquire_state_context'
    compat/regex/regex_internal.c:1553: error: expected '=3D', ',', ';'=
,
'asm' or '__attribute__' before 'register_state'
    compat/regex/regex_internal.c:1608: error: expected '=3D', ',', ';'=
,
'asm' or '__attribute__' before 'create_ci_newstate'
    compat/regex/regex_internal.c:1658: error: expected '=3D', ',', ';'=
,
'asm' or '__attribute__' before 'create_cd_newstate'
    In file included from compat/regex/regex.c:74:
    compat/regex/regcomp.c: In function 're_compile_internal':
    compat/regex/regcomp.c:778: warning: implicit declaration of
function 're_string_construct'
    compat/regex/regcomp.c: In function 'create_initial_state':
    compat/regex/regcomp.c:969: warning: implicit declaration of
function 're_node_set_init_copy'
    compat/regex/regcomp.c:1002: warning: implicit declaration of
function 're_node_set_merge'
    compat/regex/regcomp.c:1013: warning: implicit declaration of
function 're_acquire_state_context'
    compat/regex/regcomp.c:1013: warning: assignment makes pointer
from integer without a cast
    compat/regex/regcomp.c:1020: warning: assignment makes pointer
from integer without a cast
    compat/regex/regcomp.c:1022: warning: assignment makes pointer
from integer without a cast
    compat/regex/regcomp.c:1026: warning: assignment makes pointer
from integer without a cast
    compat/regex/regcomp.c: In function 'link_nfa_nodes':
    compat/regex/regcomp.c:1408: warning: implicit declaration of
function 're_node_set_init_2'
    compat/regex/regcomp.c:1415: warning: implicit declaration of
function 're_node_set_init_1'
    compat/regex/regcomp.c: In function 'duplicate_node_closure':
    compat/regex/regcomp.c:1459: warning: implicit declaration of
function 're_node_set_insert'
    compat/regex/regcomp.c: In function 'calc_inveclosure':
    compat/regex/regcomp.c:1590: warning: implicit declaration of
function 're_node_set_insert_last'
    compat/regex/regcomp.c: In function 'calc_eclosure_iter':
    compat/regex/regcomp.c:1653: warning: implicit declaration of
function 're_node_set_alloc'
    In file included from compat/regex/regex.c:75:
    compat/regex/regexec.c: In function 'regexec':
    compat/regex/regexec.c:230: warning: unused variable 'dfa'
    compat/regex/regexec.c: In function 're_search_stub':
    compat/regex/regexec.c:418: warning: unused variable 'dfa'
    compat/regex/regexec.c: At top level:
    compat/regex/regexec.c:629: error: expected '=3D', ',', ';', 'asm'
or '__attribute__' before 're_search_internal'
    compat/regex/regexec.c:636: error: expected identifier or '('
before '{' token
    compat/regex/regexec.c:956: error: expected '=3D', ',', ';', 'asm'
or '__attribute__' before 'prune_impossible_nodes'
    compat/regex/regexec.c:958: error: expected identifier or '('
before '{' token
    compat/regex/regexec.c: In function 'acquire_init_state_context':
    compat/regex/regexec.c:1074: warning: return makes pointer from
integer without a cast
    compat/regex/regexec.c: At top level:
    compat/regex/regexec.c:1095: error: expected '=3D', ',', ';', 'asm'
or '__attribute__' before 'check_matching'
    compat/regex/regexec.c:1368: error: expected '=3D', ',', ';', 'asm'
or '__attribute__' before 'push_fail_stack'
    compat/regex/regexec.c:1415: error: expected '=3D', ',', ';', 'asm'
or '__attribute__' before 'set_regs'
    compat/regex/regexec.c:1669: error: expected '=3D', ',', ';', 'asm'
or '__attribute__' before 'build_sifted_states'
    compat/regex/regexec.c: In function 'merge_state_array':
    compat/regex/regexec.c:1768: warning: implicit declaration of
function 're_node_set_init_union'
    compat/regex/regexec.c:1772: warning: implicit declaration of
function 're_acquire_state'
    compat/regex/regexec.c:1772: warning: assignment makes pointer
from integer without a cast
    compat/regex/regexec.c: In function 'update_cur_sifted_state':
    compat/regex/regexec.c:1815: warning: assignment makes pointer
from integer without a cast
    compat/regex/regexec.c: At top level:
    compat/regex/regexec.c:1831: error: expected '=3D', ',', ';', 'asm'
or '__attribute__' before 'add_epsilon_src_nodes'
    compat/regex/regexec.c: In function 'sub_epsilon_src_nodes':
    compat/regex/regexec.c:1884: warning: implicit declaration of
function 're_node_set_add_intersect'
    compat/regex/regexec.c: At top level:
    compat/regex/regexec.c:2144: error: expected '=3D', ',', ';', 'asm'
or '__attribute__' before 'sift_states_bkref'
    compat/regex/regexec.c:2274: error: expected '=3D', ',', ';', 'asm'
or '__attribute__' before 'transit_state'
    compat/regex/regexec.c: In function 'merge_state_with_log':
    compat/regex/regexec.c:2375: warning: assignment makes pointer
from integer without a cast
    compat/regex/regexec.c: In function 'transit_state_bkref':
    compat/regex/regexec.c:2648: warning: assignment makes pointer
from integer without a cast
    compat/regex/regexec.c:2665: warning: assignment makes pointer
from integer without a cast
    compat/regex/regexec.c: At top level:
    compat/regex/regexec.c:2699: error: expected '=3D', ',', ';', 'asm'
or '__attribute__' before 'get_subexp'
    compat/regex/regexec.c:2899: error: expected '=3D', ',', ';', 'asm'
or '__attribute__' before 'check_arrival'
    compat/regex/regexec.c:3060: error: expected '=3D', ',', ';', 'asm'
or '__attribute__' before 'check_arrival_add_next_nodes'
    compat/regex/regexec.c:3192: error: expected '=3D', ',', ';', 'asm'
or '__attribute__' before 'check_arrival_expand_ecl_sub'
    compat/regex/regexec.c:3236: error: expected '=3D', ',', ';', 'asm'
or '__attribute__' before 'expand_bkref_cache'
    compat/regex/regexec.c: In function 'build_trtable':
    compat/regex/regexec.c:3434: warning: assignment makes pointer
from integer without a cast
    compat/regex/regexec.c:3442: warning: assignment makes pointer
from integer without a cast
    compat/regex/regexec.c:3450: warning: assignment makes pointer
from integer without a cast
    compat/regex/regexec.c: At top level:
    compat/regex/regexec.c:4102: error: expected '=3D', ',', ';', 'asm'
or '__attribute__' before 'extend_buffers'
    compat/regex/regexec.c:4165: error: expected '=3D', ',', ';', 'asm'
or '__attribute__' before 'match_ctx_init'
    compat/regex/regexec.c:4238: error: expected '=3D', ',', ';', 'asm'
or '__attribute__' before 'match_ctx_add_entry'
    compat/regex/regexec.c:4310: error: expected '=3D', ',', ';', 'asm'
or '__attribute__' before 'match_ctx_add_subtop'
    gmake: *** [compat/regex/regex.o] Error 1
